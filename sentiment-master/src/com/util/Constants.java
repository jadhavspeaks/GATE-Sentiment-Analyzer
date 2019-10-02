package com.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class Constants {

	public static String POS = null;
	public static String ADVERBS_PATTERN = null;
	public static String NEG_PATTERN = null;
	public static String GATE_VERSION = null;
	public static String ENGLISHDICTFILE = null;
	public static String KEY_SPELLCORRECTION_FILE = null;

	static {
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream("E:/umesh/umesh/Sentiment/Sentiment1/conf/Rules.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		POS = properties.getProperty("Constants.POS"); //$NON-NLS-1$
		ADVERBS_PATTERN = properties.getProperty("Constants.ADVERBS_PATTERN"); //$NON-NLS-1$
		NEG_PATTERN = properties.getProperty("Constants.NEG_PATTERN"); //$NON-NLS-1$
		GATE_VERSION = properties.getProperty("Constants.GATE_VERSION"); //$NON-NLS-1$
		ENGLISHDICTFILE = properties.getProperty("Constants.ENGLISH_DICT_FILE"); //$NON-NLS-1$
		KEY_SPELLCORRECTION_FILE = properties.getProperty("Constants.KEY_SPELLCORRECTION_FILE"); //$NON-NLS-1$
	}

	public static String gateHome = "E:/umesh/umesh/Sentiment/Sentiment1/gate-7.0-build4195-ALL/gate-7.0-build4195-ALL";
}
