package com.sentimentanalysis;


import java.io.BufferedReader;
import java.io.IOException;

public class SynchronizedReader {
	BufferedReader br;
	public SynchronizedReader(BufferedReader br ) {
		this.br = br;
	}
	
	public synchronized String getNextLine()
	{
		try {
			return br.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
