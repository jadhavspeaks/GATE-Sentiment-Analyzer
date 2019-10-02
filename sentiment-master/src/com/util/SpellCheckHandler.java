package com.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;

public class SpellCheckHandler {

	private static final Object obj = new Object();
	private static SpellCheckHandler spellCheckObj = null;
	private static HashMap<String, String> spellCorrectionMap = new HashMap<String, String>();
	private static TATokenizer ta = new TATokenizer();

	/**
	 * private constructor to keep the class singleton
	 */
	private SpellCheckHandler() {
		;
	}

	/**
	 * @return the instance of the {@link SpellCheckHandler} object to be used
	 *         as a singleton object
	 */
	public static SpellCheckHandler getInstance() {
		synchronized (obj) {
			if (null == spellCheckObj) {
				spellCheckObj = new SpellCheckHandler();
				spellCheckObj.loadSpellMap();
			}
		}
		return spellCheckObj;
	}

	private void loadSpellMap() {
		Configuration prop = Configuration.getInstance();
		String spellFile = prop.getProperty(Constants.KEY_SPELLCORRECTION_FILE);
		synchronized (obj) {
			try {
				BufferedReader br = new BufferedReader(new FileReader(spellFile));
				String line = null;
				while (null != (line = br.readLine())) {
					String[] toks = line.split(",");
					if (toks.length == 2) {
						spellCorrectionMap.put(toks[0], toks[1]);
					} else {
					}
				}
				br.close();
			} catch (Exception e) {
				System.out.println("");
			}
		}
	}

	/**
	 * @param word
	 * @return returns corrected spelling for the input parameter if there
	 *         exists one. Else it will return same word.
	 */
	public String getCorrectSpelling(String word) {
		if (spellCorrectionMap.containsKey(word)) {
			return spellCorrectionMap.get(word);
		}
		return word;
	}

	public String getCorrectedComment(String comment) {
		StringBuilder sb = new StringBuilder();
		String[] words = ta.getTokens(comment);
		for (String word : words) {
			word = getCorrectSpelling(word);
			sb.append(word).append(" ");
		}
		return sb.toString().trim();
	}
}
