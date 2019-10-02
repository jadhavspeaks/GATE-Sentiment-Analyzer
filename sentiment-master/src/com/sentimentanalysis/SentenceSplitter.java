package com.sentimentanalysis;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.util.Configuration;

public class SentenceSplitter {
	private static String sentenceRegex = "([^\\.?!;]+)([\\.?!;]{0,})";
	private static String conjunctionString = "(\\s([Aa]nd|[Bb]ut|[Yy]et|[Oo]r|[Nn]or|[Ff]or|[Ss]o|[Tt]hough|[Aa]lthough|[Aa]fter|[Bb]efore[Bb]ecause|[Aa]s|[Ii]f|[Oo]nce|[Ss]ince|[Tt]han|[Tt]hat|[Tt]ill|[Uu]ntill)\\s)|,";
	private TextAnalysis textAnalysis = null;

	public static String getSentenceRegex() {
		return sentenceRegex;
	}

	public static void setSentenceRegex(String sentenceRegex) {
		SentenceSplitter.sentenceRegex = sentenceRegex;
	}

	public static String getConjunctionString() {
		return conjunctionString;
	}

	/**
	 * 
	 * @param conjunctionString
	 *            - String should be in a form of a <b>regex</b> used internally
	 *            to split sentences based on some values.
	 *            <p>
	 *            Also you can just pass an empty string saying just don't split
	 *            the document.
	 * 
	 */
	public static void setConjunctionString(String conjunctionString) {
		SentenceSplitter.conjunctionString = conjunctionString;
	}

	private List<String> splitOnDelimiter(String comment) {
		List<String> strArr = new ArrayList<String>();
		if (sentenceRegex != null && sentenceRegex.trim().length() > 0) {
			// String[] strArr = comment.split(delimRegex);

			Pattern pattern = Pattern.compile(sentenceRegex);
			Matcher match = pattern.matcher(comment);
			while (match.find()) {
				String sentence = match.group(0).trim();
				if (sentence.length() > 0)
					strArr.add(sentence);
			}
		} else {
			strArr.add(comment);
		}
		return strArr;

	}

	private String[] splitOnConjunction(String sentence) {
		String[] strArray = null;
		if (conjunctionString != null && conjunctionString.length() > 0)
			strArray = sentence.split(conjunctionString);
		else {
			strArray = new String[1];
			strArray[0] = sentence;
		}
		return strArray;
	}

	/**
	 * Initialization of all the entities before calculation of sentiment
	 * analysis. Must be called before calculating sentiment score or may lead
	 * to exception.
	 */
	public void init() {
		String confPath = System.getProperty("user.dir") + File.separator;

		TextAnalysis.loadProps();

		Configuration.setPropFileName(confPath + Configuration.getPropFileName());
		GateProcessor.initGate(1);
		textAnalysis = new TextAnalysis("");
	}

	public TextAnalysis.Result calculateScore(String comment) {
		List<String> splitSentence = splitOnDelimiter(comment);

		Double finalScores = 0.0;
		String postiveWords = "";
		String negativeWords = "";
		TextAnalysis.Result resultObj = textAnalysis.new Result();

		for (String sentence : splitSentence) {

			String[] commentSplit = splitOnConjunction(sentence);
			for (String snippet : commentSplit) {

				if (snippet.length() > 1) {
					Pattern patt = Pattern.compile("[A-Za-z]");
					Matcher mat = patt.matcher(snippet.trim());

					if (mat.find()) {
						if (snippet.contains("?"))
							continue;
						textAnalysis.docString = snippet.trim();
						TextAnalysis.Result res = textAnalysis.doAnalysis();
						finalScores += res.score;
						postiveWords += res.posWords;
						negativeWords += res.negWords;
					}
				}
			}
		}
		resultObj.score = finalScores;
		resultObj.negWords = negativeWords;
		resultObj.posWords = postiveWords;

		return resultObj;
	}

	public static void main(String[] args) throws IOException {

		SentenceSplitter s = new SentenceSplitter();
		s.init();

		TextAnalysis.Result resultObj = s.calculateScore("This is a good product but camera is not very good");
		System.out.println("\n\n\tResult :" + resultObj);
	}
}
