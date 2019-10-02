package com.util;

import java.io.FileInputStream;
import java.util.Properties;

public class Configuration {

	private static Configuration instance = null;
	private static String fileExtn = ".config";
	private static String propFileName = "conf/mm"+fileExtn;
	private static Properties props = null;

	/**
	 * Get the instance of the singleton properties wrapper.
	 * 
	 * @return Configuration instance.
	 */
	public static Configuration getInstance() {
		if (instance == null)
			instance = new Configuration();
		return instance;
	}

	private Configuration() {
		getProps();
	}

	/**
	 * @return Properties object after loading.
	 */
	private Properties getProps() {
		if (null == props) {
			loadProperties();
		}
		return props;
	}

	/**
	 * Loads Properties File.
	 */
	private void loadProperties() {
		try {
			System.out.println(propFileName);
			props = new Properties();
			// Get the file as input stream and pass it to the parser.
			props.load(new FileInputStream(propFileName));
			
		} catch (Exception e) {
		}
	}

	public String getProperty(String key) {

		String propertyString = getProps().getProperty(key);
		// No matching string for the key found. Just return null back
		return propertyString;
	}

	public static String getPropFileName() {
		return propFileName;
	}

	public static void setPropFileName(String propFileName) {
		Configuration.propFileName = propFileName;
	}
}