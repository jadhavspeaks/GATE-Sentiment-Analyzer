package com.sentimentanalysis;

import gate.Annotation;
import gate.AnnotationSet;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.FeatureMap;
import gate.Gate;
import gate.ProcessingResource;
import gate.corpora.DocumentContentImpl;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sentimentanalysis.DocumentData.SentimentWordAttr;
import com.sentimentanalysis.GATEEntityExtractor.SortedAnnotationList;
import com.util.Constants;

public class GateProcessor {

	public static ArrayList<SentenceObj> arrOfSentObj = new ArrayList<SentenceObj>();
	public static ArrayList<ProductObj> arrOfProdObj = new ArrayList<ProductObj>();

	private static SerialAnalyserController[] annieController = null;

	private static final String PLUGIN = "plugins";
	private static final String ANNIE = "ANNIE";
	private static final String GATE_HOME = "gate.home";

	private static final int PROXIMITY_LEVEL = 10;
	private static String delimeter = "%%";
	private static String patternDelimeter = ":::";

	public static ArrayList<SentenceChunk> sentencesChunk = new ArrayList<SentenceChunk>();

	private Document doc = null;

	public static Boolean isAnnieInit = false;

	Map<Integer, Integer> mapArrOffset = new HashMap<Integer, Integer>();
	String docStr;

	public static SerialAnalyserController[] getAnnieController() {
		return annieController;
	}

	/**
	 * Set GATE_HOME and initialize ANNIE and set plugins
	 * 
	 * @param threads
	 */
	@SuppressWarnings("deprecation")
	public static void initGate(Integer threads) {
		
		if(Gate.getGateHome()==null){
			System.setProperty(GATE_HOME, Constants.gateHome);
			Gate.setGateHome(new File(Constants.gateHome));
		}

		try {
			Gate.init();
			// Load ANNIE plugin
			File gateHome = Gate.getGateHome();
			gateHome = new File(Constants.gateHome);
			File pluginsHome = new File(gateHome, PLUGIN);

			Gate.getCreoleRegister().registerDirectories(new File("E:/umesh/umesh/Sentiment/Sentiment1/gate-7.0-build4195-ALL/gate-7.0-build4195-ALL/plugins/ANNIE/").toURI().toURL());

			initializeAnnie(threads);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (GateException e) {
			e.printStackTrace();
		}
	}

	public GateProcessor(String docStr) {
		this.docStr = docStr;
	}

	/**
	 * Initialise the ANNIE system. This creates a "corpus pipeline" application
	 * that can be used to run sets of documents through the extraction system.
	 * 
	 * @param threads
	 */
	@SuppressWarnings("deprecation")
	public static void initializeAnnie(int threads) {

		annieController = new SerialAnalyserController[threads];
		for (int i = 0; i < threads; i++) {

			String[] strModel = new String[7];
			strModel[0] = "gate.creole.annotdelete.AnnotationDeletePR";
			strModel[1] = "gate.creole.tokeniser.DefaultTokeniser";
			strModel[2] = "gate.creole.splitter.SentenceSplitter";
			strModel[3] = "gate.creole.gazetteer.DefaultGazetteer";
			strModel[4] = "gate.creole.POSTagger";
			strModel[5] = "gate.creole.ANNIETransducer";
			strModel[6] = "gate.creole.orthomatcher.OrthoMatcher";

			FeatureMap[] params = new FeatureMap[7];
			FeatureMap documentParameter = Factory.newFeatureMap();
			params[0] = documentParameter;
			documentParameter = Factory.newFeatureMap();
			params[1] = documentParameter; // use default parameters
			documentParameter = Factory.newFeatureMap();
			params[2] = documentParameter; // use default parameters
			documentParameter = Factory.newFeatureMap();
			documentParameter.put("caseSensitive", "false");
			documentParameter.put("gazetteerFeatureSeparator", "&");
			params[3] = documentParameter; // use default parameters
			documentParameter = Factory.newFeatureMap();
			params[4] = documentParameter; // use default parameters
			documentParameter = Factory.newFeatureMap();
			params[5] = documentParameter;
			documentParameter = Factory.newFeatureMap();
			params[6] = documentParameter; // use default parameters

			annieController[i] = createResource(strModel, params);
			System.out.println("initializing controller.. " + i);
		}

		// log.info( "...GATE initialised" );
		isAnnieInit = true;
	}

	/**
	 * Create a serial analyzer controller to run ANNIE with
	 * 
	 * @param arrModel
	 * @param params
	 * @return
	 */
	public static SerialAnalyserController createResource(String[] arrModel, FeatureMap[] params) {
		SerialAnalyserController controller = null;
		try {
			{
				controller = (SerialAnalyserController) Factory.createResource("gate.creole.SerialAnalyserController", Factory.newFeatureMap(), Factory.newFeatureMap(), "ANNIE_"
						+ Gate.genSym());
				// load each PR as defined in ANNIEConstants
				for (int i = 0; i < arrModel.length; i++) {
					ProcessingResource pr;
					pr = (ProcessingResource) Factory.createResource(arrModel[i], params[i]);
					// add the PR to the pipeline controller
					controller.add(pr);
				}
			}
		} catch (ResourceInstantiationException e) {
			e.printStackTrace();
		}
		return controller;
	}

	/**
	 * Run ANNIE
	 * 
	 * @param controller
	 * @throws GateException
	 */
	public void execute(SerialAnalyserController controller) throws GateException {
		controller.execute();
	}

	/**
	 * Create a GATE corpus and add a document
	 * 
	 * @param docStr
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Corpus createCorpus(String docStr) {
		Corpus corpus = null;
		try {
			corpus = (Corpus) Factory.createResource("gate.corpora.CorpusImpl");
			FeatureMap params = Factory.newFeatureMap();
			params.put("preserveOriginalContent", new Boolean(true));
			params.put("collectRepositioningInfo", new Boolean(true));
			// log.info("Creating doc for " + u);
			doc = (Document) Factory.createResource("gate.corpora.DocumentImpl", params);
			doc.setContent(new DocumentContentImpl(docStr));
			corpus.add(doc);

		} catch (ResourceInstantiationException e) {
			e.printStackTrace();
		}
		return corpus;
	}

	/**
	 * For each document in the corpus, get document with the "Neg" and "Pos"
	 * names added. If the Annotation is negative then set the score value to
	 * -0.5 to SentimentWordAttr If the Annotation is positive then set the
	 * score value to +0.5 to SentimentWordAttr
	 * 
	 * @param threadId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DocumentData process(int threadId, double score) {

		Corpus corpus = createCorpus(docStr);

		// Tell ANNIE's controller about the corpus you want to run on

		annieController[threadId].setCorpus(corpus);

		try {
			execute(annieController[threadId]);
		} catch (GateException e) {
			System.out.println("Thread: " + threadId + " " + corpus.size());
			e.printStackTrace();
		}

		Iterator iter = corpus.iterator();
		DocumentData docData = new DocumentData();

		Map<Long, String> mapAnnotations = new HashMap<Long, String>();
		Map<Integer, Long> mapIdToOffsetOriginal = new HashMap<Integer, Long>();
		while (iter.hasNext()) {
			doc = (Document) iter.next();
			AnnotationSet defaultAnnotSet = doc.getAnnotations();
			AnnotationSet annSetSentence = defaultAnnotSet.get("Sentence");

			AnnotationSet annSetToken = defaultAnnotSet.get("Token");

			Set<String> annotTypesRequired = new HashSet<String>();
			annotTypesRequired.add("Neg");
			annotTypesRequired.add("Pos");
			AnnotationSet annSet = defaultAnnotSet.get(annotTypesRequired);

			HashSet<Long> sentenceSplitSet = new HashSet<Long>();
			String originalContent = doc.getContent().toString();

			if (originalContent != null) {
				Iterator it = annSetSentence.iterator();
				Annotation currAnnot;
				SortedAnnotationList sortedAnnotations_token = new SortedAnnotationList();

				while (it.hasNext()) {
					currAnnot = (Annotation) it.next();
					sentenceSplitSet.add(currAnnot.getStartNode().getOffset());
				} // while

				it = annSetToken.iterator();
				while (it.hasNext()) {
					currAnnot = (Annotation) it.next();
					sortedAnnotations_token.addSortedExclusive(currAnnot);
				} // while

				StringBuilder posTagSent = new StringBuilder();
				Integer prevOffset = 0;
				for (int i = 0; i < sortedAnnotations_token.size(); i++) {
					currAnnot = (Annotation) sortedAnnotations_token.get(i);
					FeatureMap fm = currAnnot.getFeatures();

					String annottype = currAnnot.getType();
					if (sentenceSplitSet.contains(currAnnot.getStartNode().getOffset()) && currAnnot.getStartNode().getOffset() != 0) {
						Long startOffset = currAnnot.getStartNode().getOffset();
						// Long endOffset = currAnnot.getEndNode().getOffset();
						docData.getSentences().add(docStr.substring(prevOffset, startOffset.intValue()));
						docData.getSentSplitOffsets().add(startOffset);
						docData.getPOSTagSent().add(posTagSent.toString().trim());
						posTagSent = new StringBuilder();
						prevOffset = startOffset.intValue();
					}
					if (annottype.equalsIgnoreCase("Token")) {
						String posTag = (String) fm.get("category");
						String word = (String) fm.get("string");
						posTagSent.append(word).append("/").append(posTag).append(" ");
						mapAnnotations.put(currAnnot.getStartNode().getOffset(), word);
						mapIdToOffsetOriginal.put(i, currAnnot.getStartNode().getOffset());

					}
				}

				docData.getSentences().add(docStr.substring(prevOffset, docStr.length()));
				docData.getSentSplitOffsets().add((long) docStr.length());
				docData.getPOSTagSent().add(posTagSent.toString().trim());
				docData.setLegthDoc(mapAnnotations.size());

				// ********************* START ******************************
				try {

					String temp = "";
					StringBuffer tokens = new StringBuffer();
					for (int i = 0; i < sortedAnnotations_token.size(); i++) {
						currAnnot = (Annotation) sortedAnnotations_token.get(i);
						temp = (String) currAnnot.getFeatures().get("string");

					
						tokens.append(temp);
						if (!(temp.equals(".") | temp.equals(",") | temp.equals(";")))
							tokens.append(" ");
					}

				} catch (Exception e1) {
					e1.printStackTrace();
				}
				Corpus corpus_stemmed = createCorpus(docStr);
				annieController[threadId].setCorpus(corpus_stemmed);

				try {
					execute(annieController[threadId]);
				} catch (GateException e) {
					System.out.println("Thread: " + threadId + " " + corpus.size());
					e.printStackTrace();
				}

				Iterator iter_stem = corpus_stemmed.iterator();
				Map<Long, Integer> mapOffsetToIdStem = new HashMap<Long, Integer>();
				while (iter_stem.hasNext()) {

					Document doc_stem = (Document) iter_stem.next();
					AnnotationSet defaultAnnotSet_stem = doc_stem.getAnnotations();
					AnnotationSet annSetToken_stemmed = defaultAnnotSet_stem.get("Token");
					it = annSetToken_stemmed.iterator();
					SortedAnnotationList sortedAnnotations_stem_token = new SortedAnnotationList();
					while (it.hasNext()) {
						currAnnot = (Annotation) it.next();
						sortedAnnotations_stem_token.addSortedExclusive(currAnnot);

					} // while

					for (int j = 0; j < sortedAnnotations_stem_token.size(); j++) {

						currAnnot = (Annotation) sortedAnnotations_stem_token.get(j);
						String annottype = currAnnot.getType();
						if (annottype.equalsIgnoreCase("Token")) {
							mapOffsetToIdStem.put(currAnnot.getStartNode().getOffset(), j);
						}
					}
				}

				Iterator iter_stemmed = corpus_stemmed.iterator();
				Document doc_stemmed = (Document) iter_stemmed.next();
				AnnotationSet defaultAnnotSet_stemmed = doc_stemmed.getAnnotations();
				Set<String> annotTypesRequired_stemmed = new HashSet<String>();
				annotTypesRequired_stemmed.add("Neg");
				annotTypesRequired_stemmed.add("Pos");

				AnnotationSet annSet_stemmed = defaultAnnotSet_stemmed.get(annotTypesRequired_stemmed);

				
				it = annSet_stemmed.iterator();
				SortedAnnotationList sortedAnnotations_stemmed = new SortedAnnotationList();
				while (it.hasNext()) {

					currAnnot = (Annotation) it.next();

					sortedAnnotations_stemmed.addSortedExclusive(currAnnot);

				} // while
				for (int i = 0; i < sortedAnnotations_stemmed.size(); i++) {
					currAnnot = (Annotation) sortedAnnotations_stemmed.get(i);

					String annottype = currAnnot.getType();
					if (annottype.equalsIgnoreCase("Neg")) {
						Long startOffset = mapIdToOffsetOriginal.get(mapOffsetToIdStem.get(Long.parseLong(currAnnot.getStartNode().getOffset().toString())));
						SentimentWordAttr sentimentWordAttr = docData.new SentimentWordAttr();
						sentimentWordAttr.setOffset(startOffset);
						sentimentWordAttr.setScore(-score);

						int startOff = Integer.parseInt(currAnnot.getStartNode().getOffset().toString());
						int endOff = Integer.parseInt(currAnnot.getEndNode().getOffset().toString());
						sentimentWordAttr.setWord(docStr.substring(startOff, endOff));

						docData.getNegWords().add(sentimentWordAttr);
					} else if (annottype.equalsIgnoreCase("Pos")) {
						Long startOffset = mapIdToOffsetOriginal.get(mapOffsetToIdStem.get(Long.parseLong(currAnnot.getStartNode().getOffset().toString())));
						SentimentWordAttr sentimentWordAttr = docData.new SentimentWordAttr();
						sentimentWordAttr.setOffset(startOffset);
						sentimentWordAttr.setScore(score);


						int startOff = Integer.parseInt(currAnnot.getStartNode().getOffset().toString());
						int endOff = Integer.parseInt(currAnnot.getEndNode().getOffset().toString());
						sentimentWordAttr.setWord(docStr.substring(startOff, endOff));
						docData.getPosWords().add(sentimentWordAttr);

					}

				} // for
				annSet_stemmed = null;
				sortedAnnotations_stemmed = null;
				annotTypesRequired_stemmed = null;
				defaultAnnotSet_stemmed = null;
				mapOffsetToIdStem = null;
				sortedAnnotations_token = null;
			}// if original content
			// System.out.println("************");

			annotTypesRequired = null;
			annSetSentence = null;
			sentenceSplitSet = null;
			annSet = null;
			defaultAnnotSet = null;

			Factory.deleteResource(doc);
		}// while iter
		cleanUp();
		corpus.clear();
		corpus.cleanup();
		Factory.deleteResource(corpus);
		corpus = null;
		return docData;
	}

	private void cleanUp() {
		mapArrOffset.clear();
		mapArrOffset = null;
	}

	public Document getDoc() {
		return doc;
	}

	public void setDoc(Document doc) {
		this.doc = doc;
	}

	public static void POSAnalyser(String commentStr, int threadId) throws MalformedURLException, GateException {

		Corpus corpus = (Corpus) Factory.createResource("gate.corpora.CorpusImpl");
		String contentPath = "";
		File f = new File(contentPath);
		URL u = f.toURL();
		FeatureMap params = Factory.newFeatureMap();
		params.put("sourceUrl", u);
		params.put("preserveOriginalContent", new Boolean(true));
		params.put("collectRepositioningInfo", new Boolean(true));
		// Out.prln("Creating doc for " + u);
		Document doc = (Document) Factory.createResource("gate.corpora.DocumentImpl", params);
		doc.setContent(new DocumentContentImpl(commentStr));
		corpus.add(doc);

		// tell the pipeline about the corpus and run it
		annieController[threadId].setCorpus(corpus);
		annieController[threadId].execute();

		Iterator iter = corpus.iterator();
		int count = 0;

		doc = (Document) iter.next();
		AnnotationSet defaultAnnotSet = doc.getAnnotations();
		Set annotTypesRequired = new HashSet();
		Set allTokens = new HashSet();
		Set productTokens = new HashSet();
		annotTypesRequired.add("Sentence");
		allTokens.add("Token");
		productTokens.add("Product");

		Set<Annotation> peopleAndPlaces = new HashSet<Annotation>(defaultAnnotSet.get(annotTypesRequired));
		Set<Annotation> allTokensSet = new HashSet<Annotation>(defaultAnnotSet.get(allTokens));
		Set<Annotation> productTokensSet = new HashSet<Annotation>(defaultAnnotSet.get(productTokens));

		Iterator it = peopleAndPlaces.iterator();
		Annotation currAnnot;
		SortedAnnotationList sortedAnnotations = new SortedAnnotationList();
		SortedAnnotationList sortedTokensByOffset = new SortedAnnotationList();
		FeatureMap features = doc.getFeatures();
		String content = commentStr;
		while (it.hasNext()) {
			currAnnot = (Annotation) it.next();
			sortedAnnotations.addSortedExclusive(currAnnot);
		} // while

		it = allTokensSet.iterator();
		while (it.hasNext()) {
			currAnnot = (Annotation) it.next();
			sortedTokensByOffset.addSortedExclusive(currAnnot);
		} // while

		it = sortedAnnotations.iterator();
		Annotation currToken = null;
		Integer i = 1;
		while (it.hasNext()) {
			HashMap<Integer, String> mapOfPOSTags = new HashMap<Integer, String>();
			Integer j = 1;
			currAnnot = (Annotation) it.next();
			Integer start = Integer.parseInt(currAnnot.getStartNode().getOffset().toString());
			Integer end = Integer.parseInt(currAnnot.getEndNode().getOffset().toString());

			Iterator it2 = sortedTokensByOffset.iterator();
			StringBuffer sb = new StringBuffer();
			while (it2.hasNext()) {
				currToken = (Annotation) it2.next();
				Integer startOff = Integer.parseInt(currToken.getStartNode().getOffset().toString());
				Integer endOff = Integer.parseInt(currToken.getEndNode().getOffset().toString());
				String temp = "";
				if (startOff >= start && endOff <= end) {
					sb.append(content.substring(startOff, endOff));
					sb.append("/");
					sb.append(currToken.getFeatures().get("category"));
					sb.append(" ");
					mapOfPOSTags.put(j++, (String) currToken.getFeatures().get("category"));

				} else if (endOff > end)
					break;
			}
			SentenceObj sentObj = new SentenceObj();
			sentObj.content = content.substring(start, end);
			sentObj.startOffset = start;
			sentObj.endOffset = end;
			sentObj.sentencePOSStr = sb.toString();
			sentObj.tokenVsPOSmap = mapOfPOSTags;

			arrOfSentObj.add(getSplits(sentObj));
		}

		it = productTokensSet.iterator();
		Annotation prodAnnot = null;
		sortedAnnotations.clear();
		while (it.hasNext()) {
			prodAnnot = (Annotation) it.next();
			sortedAnnotations.addSortedExclusive(prodAnnot);
		} // while

		it = sortedAnnotations.iterator();
		i = 1;
		while (it.hasNext()) {
			prodAnnot = (Annotation) it.next();
			Integer start = Integer.parseInt(prodAnnot.getStartNode().getOffset().toString());
			Integer end = Integer.parseInt(prodAnnot.getEndNode().getOffset().toString());
			// System.out.println(content.substring(start, end));
			ProductObj prodObj = new ProductObj();
			prodObj.productName = content.substring(start, end);
			prodObj.startOffset = start;
			prodObj.endOffset = end;
			arrOfProdObj.add(prodObj);
		}
		// System.out.println("");

	}

	// public static void POSAnalysier
	private static SentenceObj getSplits(SentenceObj sentObj) {
		String sent = sentObj.sentencePOSStr;
		// TODO Auto-generated method stub
		ArrayList<String> clauses = new ArrayList<String>();
		String splitExpr = " ((and|or|nor|but|yet|so)/CC)|(which/WDT)"; // Coordinating
		// conjunctions
		String sentStructureExpr = "(/(NNPS|NNP|NNS|NN|PRP[$]|PRP).+)?/(VBD|VBG|VBN|VBP|VBZ|VB).+/(NNPS|NNP|NNS|NN|JJS|JJR|JJ|RBS|RBR|RB|RP)";

		String POSTagsPattern = "/([$]|;|. |,|:|\"|-LRB-|-RRB-|AFX|CC|CD|DT|EX|FW|HYPH|IN|"
				+ "(JJS|JJR|JJ)|LS|MD|(NNPS|NNP|NNS|NN)|(PDT|POS)|(PRP[$]|PRP)|(RBS|RBR|RB|RP)|SYM|TO|UH|(VBD|VBG|VBN|VBP|VBZ|VB)|(WDT|WP|WP$|WRB))";

		Pattern pSplit = Pattern.compile(splitExpr);
		Matcher mSplit = pSplit.matcher(sent);
		boolean resSplit = false;
		HashMap<Integer, String> mapOfSplitWords = new HashMap<Integer, String>();
		while (resSplit = mSplit.find()) {
			mapOfSplitWords.put(mSplit.start(), sent.substring(mSplit.start(), mSplit.end()));
			resSplit = mSplit.matches();
		}

		Pattern p = Pattern.compile(sentStructureExpr);
		// Create a matcher with an input string
		Matcher m = null;
		boolean result = false;
		String splits[] = sent.split(splitExpr);
		int lastIndex = 0;
		String splitWord = "";
		for (int i = 0; i < splits.length; i++) {
			m = p.matcher(splits[i]);
			result = m.find();
			if (result == true) {
				clauses.add(splits[i]);
				// System.out.println("-----------------------------");
				ClauseObj clause = new ClauseObj();
				clause.clauseContent = splits[i];
				// System.out.println("clause:: "+splits[i].replaceAll(POSTagsPattern,
				// ""));
				clause = getSubjectObject(clause);
				sentObj.clauses.add(clause);
				// System.out.println("-----------------------------");
			}

			if (i < splits.length - 1) {
				splitWord = mapOfSplitWords.get(lastIndex + splits[i].length());
				// System.out.println("split:: "+splitWord);
				lastIndex = sent.indexOf(splits[i]) + splits[i].length() + splitWord.length();
			}
		}

		return sentObj;
	}

	public static void finalAnalyser(int threadId, String chunk) throws ResourceInstantiationException, ExecutionException, MalformedURLException {
		Corpus corpus = (Corpus) Factory.createResource("gate.corpora.CorpusImpl");

		File f = new File("");
		URL u = f.toURL();
		FeatureMap params = Factory.newFeatureMap();
		params.put("sourceUrl", u);
		params.put("preserveOriginalContent", new Boolean(true));
		params.put("collectRepositioningInfo", new Boolean(true));
		// Out.prln("Creating doc for " + u);
		Document doc = (Document) Factory.createResource("gate.corpora.DocumentImpl", params);
		doc.setContent(new DocumentContentImpl(chunk));
		corpus.add(doc);

		// tell the pipeline about the corpus and run it
		annieController[threadId].setCorpus(corpus);
		annieController[threadId].execute();

		// for each document, get an XML document with the
		// person and location names added
		Iterator iter = corpus.iterator();
		int count = 0;

		doc = (Document) iter.next();
		AnnotationSet defaultAnnotSet = doc.getAnnotations();
		Set annotTypesRequired = new HashSet();
		Set allTokens = new HashSet();
		Set productTokens = new HashSet();
		annotTypesRequired.add("Sentence");
		allTokens.add("Token");
		productTokens.add("Product");

		Set<Annotation> peopleAndPlaces = new HashSet<Annotation>(defaultAnnotSet.get(annotTypesRequired));
		Set<Annotation> allTokensSet = new HashSet<Annotation>(defaultAnnotSet.get(allTokens));
		Set<Annotation> productTokensSet = new HashSet<Annotation>(defaultAnnotSet.get(productTokens));

		Iterator it = peopleAndPlaces.iterator();
		Annotation currAnnot;
		SortedAnnotationList sortedAnnotations = new SortedAnnotationList();
		SortedAnnotationList sortedTokensByOffset = new SortedAnnotationList();
		FeatureMap features = doc.getFeatures();
		String content = chunk;

		// System.out.println(content);
		while (it.hasNext()) {
			currAnnot = (Annotation) it.next();
			sortedAnnotations.addSortedExclusive(currAnnot);
		} // while

		it = allTokensSet.iterator();
		while (it.hasNext()) {
			currAnnot = (Annotation) it.next();
			sortedTokensByOffset.addSortedExclusive(currAnnot);
		} // while

		it = sortedAnnotations.iterator();
		Annotation currToken = null;
		Integer i = 1;
		while (it.hasNext()) {
			HashMap<Integer, String> mapOfPOSTags = new HashMap<Integer, String>();
			Integer j = 1;
			currAnnot = (Annotation) it.next();
			Integer start = Integer.parseInt(currAnnot.getStartNode().getOffset().toString());
			Integer end = Integer.parseInt(currAnnot.getEndNode().getOffset().toString());

			Iterator it2 = sortedTokensByOffset.iterator();
			StringBuffer sb = new StringBuffer();
			while (it2.hasNext()) {
				currToken = (Annotation) it2.next();
				Integer startOff = Integer.parseInt(currToken.getStartNode().getOffset().toString());
				Integer endOff = Integer.parseInt(currToken.getEndNode().getOffset().toString());
				String temp = "";
				if (startOff >= start && endOff <= end) {
					sb.append(content.substring(startOff, endOff));
					sb.append("/");
					sb.append(currToken.getFeatures().get("category"));
					sb.append(" ");
					mapOfPOSTags.put(j++, (String) currToken.getFeatures().get("category"));

				} else if (endOff > end)
					break;
			}
			// System.out.println("*************************************************************");
			SentenceObj sentObj = new SentenceObj();
			sentObj.content = content.substring(start, end);
			sentObj.startOffset = start;
			sentObj.endOffset = end;
			// System.out.println(sentObj.content);
			// mapOfSentsStructures.put(i,mapOfPOSTags);
			sentObj.sentencePOSStr = sb.toString();
			sentObj.tokenVsPOSmap = mapOfPOSTags;

			// System.out.println(sb.toString());
			arrOfSentObj.add(getSplits(sentObj));
			// mapOfSents.put(i++, sentObj);
			// System.out.println("*************************************************************");
		}

	}

	

	public static ClauseObj getSubjectObject(ClauseObj cls) {
		String clause = cls.clauseContent;

		String verbPattern = "( ['A-Za-z]+/(VBZ|VBD|VBP|VB))|( [A-Za-z]+/(VBZ).+[A-Za-z]+/(VBN).+[A-Za-z]+/(VBN))";
		String verbPatternToIgnore = "to/(TO) [A-Za-z]+/(VBD|VB)";
		String POSTagsPattern = "/([$]|;|. |,|:|\"|-LRB-|-RRB-|AFX|CC|CD|DT|EX|FW|HYPH|IN|"
				+ "(JJS|JJR|JJ)|LS|MD|(NNPS|NNP|NNS|NN)|(PDT|POS)|(PRP[$]|PRP)|(RBS|RBR|RB|RP)|SYM|TO|UH|(VBD|VBG|VBN|VBP|VBZ|VB)|(WDT|WP|WP$|WRB))";
		cls.clauseString = clause.replaceAll(POSTagsPattern, "");
		Pattern pTO = Pattern.compile(verbPatternToIgnore);
		Pattern pVERB = Pattern.compile(verbPatternToIgnore);
		Matcher mTO = pTO.matcher(clause);
		boolean resultTO = mTO.find();
		String toPhrase = "";

		if (resultTO) {
			toPhrase = clause.substring(mTO.start(), mTO.end());
			clause = clause.replaceAll(toPhrase, "----");
		}
		String split[] = clause.split(verbPattern);

		if (split.length == 2 && split[0].length() > 1) {
			split[0] = split[0].replaceAll("----", toPhrase);
			split[1] = split[1].replaceAll("----", toPhrase);
			cls.clauseSubject = split[0];
			cls.clauseObject = split[1];
			// System.out.println("Subject:: "+
			// split[0].replaceAll(POSTagsPattern, ""));
			// System.out.println("Object:: "+
			// split[1].replaceAll(POSTagsPattern, ""));
		} else if (split.length == 2 && split[0].length() <= 1) {
			split[1] = split[1].replaceAll("----", toPhrase);
			cls.clauseObject = split[1];
			// System.out.println("Object:: "+
			// split[1].replaceAll(POSTagsPattern, ""));
		}
		// result = mTO.find();
		return cls;
	}
}
