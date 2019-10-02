package com.sentimentanalysis;

import java.util.Iterator;

import com.sentimentanalysis.DocumentData.SentimentWordAttr;
import com.util.Configuration;
import com.util.SpellCheckHandler;
import java.sql.*;

public class TextAnalysis extends Thread {

	private String seperator = ", ";
	private static SpellCheckHandler sch = SpellCheckHandler.getInstance();
	private static int minThresh = 0;
	private static int maxThresh = 0;
	private static int negationFactor = 0;
	private static double score = 0;
	private static double degreeFactor = 0;

	public class Result {
		public String posWords = "";
		public String negWords = "";
		public Boolean negExists;
		public String negPhrase = "";
		public Double score;
		public String phraseDegree = "";

		public int posWordsCount = 0;
		public int negWordsCount = 0;
		public int totalWordsCount = 0;
		public boolean degreeHandle = false;
		
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String query;

		public String toString() {
			return "Score: " + score + "\tPos Words: " + posWords + "\tNeg Words: " + negWords + "\tnegPhrase : " + negPhrase;
			
		}
		
	}

	public String docString = null;
	private String docStrSpellCorrected;
	private Result result;
	private int thread;
	private SynchronizedReader sr;

	public TextAnalysis(String docString) {
		this.docString = docString;
	}

	public TextAnalysis(String docString, int minThresh, int maxThresh, int negationFactor, double score, double degreeFactor) {
		this.docString = docString;
		this.minThresh = minThresh;
		this.maxThresh = maxThresh;
		this.negationFactor = negationFactor;
		this.score = score;
		this.degreeFactor = degreeFactor;
	}

	public TextAnalysis(SynchronizedReader sr, int thread) {
		this.thread = thread;
		this.sr = sr;
	}

	public void setResult(Result res) {
		this.result = res;
	}

	public Result getResult() {
		return result;
	}

	/**
	 * Correct the spellings, and send the comments for processing to calculate
	 * the score value
	 * 
	 * @return Result
	 */
	public Result doAnalysis() {
		docString = sch.getCorrectedComment(docString);
		docStrSpellCorrected = docString;
		GateProcessor annie = new GateProcessor(docString);
		DocumentData docData = annie.process(0, score);
		annie = null;
		Result res = calSentiScore(docData);
		return res;

	}

	private Result calSentiScore(DocumentData docData) {
		Result res = new Result();
		NegHandler negHandler = new NegHandler();
		DegreeHandler degreeHandler = new DegreeHandler();
		int k = 0;
		double scorev = 0.0;
		String sentStr = docStrSpellCorrected;
		Long startOffset = 0L;
		for (Iterator<String> iter = docData.getPOSTagSent().iterator(); iter.hasNext(); k++) {
			Double sentScore = 0.0;
			String posTagSent = iter.next();
			String negPhrase = negHandler.findNegationExists(posTagSent);
			System.out.println("negPhrase:::" + negPhrase);

			String phraseDegree = degreeHandler.findDegreeExists(posTagSent);
			System.out.println("phraseDegree:::" + phraseDegree);

			Long sentenceOffset = docData.getSentSplitOffsets().get(k);
			System.out.println(" SentenceOffset: " + sentenceOffset);
			int negPhraseOffset = -1;
			if (negPhrase != null)
				negPhraseOffset = sentStr.indexOf(negPhrase);
			System.out.println("NegPhraseOffset: " + negPhraseOffset);

			int posPhraseOffset = -1;
			if (phraseDegree != null) {
				posPhraseOffset = sentStr.indexOf(phraseDegree);
			}
			boolean isNegationApplied = false;
			boolean isDegreeApplied = false;

			for (Iterator<SentimentWordAttr> iterator = docData.getPosWords().iterator(); iterator.hasNext();) {
				SentimentWordAttr posSentiments = iterator.next();
				System.out.println("posSentiments: " + posSentiments);
				Double wordScore = posSentiments.getScore();
				Long offset = posSentiments.getOffset();
				System.out.println("Offset: " + offset);

				if (offset < sentenceOffset && offset >= startOffset) {
					// If negation with an adverb is in the sentence.
					if (negPhrase != null && !isNegationApplied && phraseDegree != null && !isDegreeApplied) {
						if (posSentiments.getOffset() > negPhraseOffset && posSentiments.getOffset() > posPhraseOffset && ((posSentiments.getOffset() - negPhraseOffset) < 40)) {
							isDegreeApplied = true;
							isNegationApplied = true;
							Double score = wordScore * degreeFactor;
							Double degreeScore = score - wordScore;
							wordScore = wordScore + (negationFactor * degreeScore);
							System.out.println(" Word Score:" + wordScore);

						}
					} else {
						isNegationApplied = false;
						if (negPhrase != null && !isNegationApplied) {
							if (posSentiments.getOffset() > negPhraseOffset && ((posSentiments.getOffset() - negPhraseOffset) < 40)) {
								isNegationApplied = true;
								wordScore = wordScore * (negationFactor);
								System.out.println("WordScore:" + wordScore);
							}
						}

						if (phraseDegree != null && !isDegreeApplied) {
							if (posSentiments.getOffset() > posPhraseOffset) {
								isDegreeApplied = true;
								wordScore = wordScore * (degreeFactor);
								System.out.println("WordScore:" + wordScore);

							}
						}
					}

					sentScore = sentScore + wordScore;
					res.posWords = res.posWords + (posSentiments.getWord() + seperator);

				}
			}

			isNegationApplied = false;
			isDegreeApplied = false;
			for (Iterator<SentimentWordAttr> iterator = docData.getNegWords().iterator(); iterator.hasNext();) {
				SentimentWordAttr negSentiments = iterator.next();
				System.out.println("neg: " + negSentiments);
				Double wordScore = negSentiments.getScore();
				Long noffset = negSentiments.getOffset();
				System.out.println("Negation Offset:" + noffset);

				if (noffset < sentenceOffset && noffset >= startOffset) {
					// If negation with an adverb is in the sentence.
					if (negPhrase != null && !isNegationApplied && phraseDegree != null && !isDegreeApplied) {
						if (negSentiments.getOffset() > negPhraseOffset && negSentiments.getOffset() > posPhraseOffset && ((negSentiments.getOffset() - negPhraseOffset) < 40)) {

							isDegreeApplied = true;
							isNegationApplied = true;
							Double score = wordScore * degreeFactor;
							Double degreeScore = score - wordScore;
							wordScore = wordScore + (negationFactor * degreeScore);
							System.out.println(" Word Score:" + wordScore);

						}
					} else {
						if (negPhrase != null && !isNegationApplied) {
							if (negSentiments.getOffset() > negPhraseOffset) {
								isNegationApplied = true;
								wordScore = wordScore * (negationFactor);
							}
						}
						if (phraseDegree != null && !isDegreeApplied) {
							if (negSentiments.getOffset() > negPhraseOffset) {
								isDegreeApplied = true;
								wordScore = wordScore * (degreeFactor);
							}
						}
					}
					sentScore = sentScore + wordScore;
					res.negWords = res.negWords + (negSentiments.getWord() + seperator);

				}

			}

			startOffset = sentenceOffset;
			res.negPhrase = negPhrase;
			res.phraseDegree = phraseDegree;
			scorev = scorev + sentScore;

		}
		res.posWordsCount = docData.getPosWords().size();
		res.negWordsCount = docData.getNegWords().size();
		res.totalWordsCount = docData.getLegthDoc();
		res.degreeHandle = (res.phraseDegree != null ? true : false);

		if (scorev > maxThresh) {
			scorev = maxThresh;
		}
		if (scorev < minThresh) {
			scorev = minThresh;
		}

		res.score = scorev;
		int pos = res.posWordsCount;
		int neg = res.negWordsCount;
		try 
		{
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM","manager");
			PreparedStatement pst = con.prepareStatement("insert into Score values(?,?)");
			pst.setInt(1, pos);
			pst.setInt(2, neg);
			ResultSet rs = pst.executeQuery();		
		}
			catch (SQLException se) 
		{
			System.out.println("sql exception has occuttreee " + se);
		}
		return res;

	}


	public static void loadProps() {
		minThresh=-5;
		maxThresh=5;
		score=0.5;
		negationFactor=-1;
		degreeFactor=1.5;
	}
}