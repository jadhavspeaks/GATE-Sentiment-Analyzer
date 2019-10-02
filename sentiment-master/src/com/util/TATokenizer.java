package com.util;

import java.util.ArrayList;
import java.util.StringTokenizer;

public class TATokenizer  {
	private static String DELIMITERS = "~!@#$%^&*()_+=-\\][{}|; \n\r\t:\",./<>?";
	
	public TATokenizer() {

	}

	/**
	 * @param line
	 * @return tokenizes the line and returns the tokens as an array of string
	 *         tokens
	
	 */
	public String[] getTokens(String line) {
		ArrayList<String> arr = new ArrayList<String>();
		StringTokenizer strtTokenizer = new StringTokenizer(line, DELIMITERS);
		while (strtTokenizer.hasMoreTokens()) {
			arr.add(strtTokenizer.nextToken());
		}
		return arr.toArray(new String[arr.size()]);
	}

	public static String getDELIMITERS() {
		return DELIMITERS;
	}

	public static void setDELIMITERS(String delimiters) {
		DELIMITERS = delimiters;
	}
}