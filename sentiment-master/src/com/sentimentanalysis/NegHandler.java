package com.sentimentanalysis;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.util.Constants;

public class NegHandler {
	private static Pattern patternRegex = null;

	static {
		String negPattern = Constants.NEG_PATTERN;
		patternRegex = Pattern.compile(negPattern, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	}

	public String negation(String text) throws IOException {
		Matcher matcher = null;

		matcher = patternRegex.matcher(text);
		if (matcher.find()) {
			String str = matcher.group(0);
			str = str.replaceAll("/[\\w]+", "");
			return str;
		}

		return null;
	}

	public String findNegationExists(String sent) {
		String negExists = null;
		try {
			String postext = sent;
			negExists = negation(postext);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return negExists;
	}

	public static void main(String[] args) {
		String comment = "This/DT is/VBZ not/RB very/RB bad/JJ";
		String str = new NegHandler().findNegationExists(comment);
		System.out.println("String: " + str);

	}
}