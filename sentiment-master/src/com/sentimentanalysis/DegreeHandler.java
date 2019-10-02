package com.sentimentanalysis;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.util.Constants;

public class DegreeHandler {
	private static Pattern degreePatternRegex = null;

	static {
		String adverbsPattern = Constants.ADVERBS_PATTERN + Constants.POS;
		degreePatternRegex = Pattern.compile(adverbsPattern, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	}

	public String findDegreeExists(String sent) {
		String posExists = null;
		try {
			String postext = sent;
			posExists = degree(postext);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return posExists;
	}

	public String degree(String text) throws IOException {
		Matcher matcher = null;
		matcher = degreePatternRegex.matcher(text);
		if (matcher.find()) {
			String str = matcher.group(0);
			str = str.replaceAll("/[\\w]+", "");
			return str;
		}
		return null;
	}
}
