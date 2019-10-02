package com.sentimentanalysis;

import java.util.ArrayList;

public class DocumentData {
	
	ArrayList<SentimentWordAttr> posWords = new ArrayList<SentimentWordAttr>();
	ArrayList<SentimentWordAttr> negWords = new ArrayList<SentimentWordAttr>();
	ArrayList<String> sentences = new ArrayList<String>();
	ArrayList<Long> sentSplitOffsets = new ArrayList<Long>();
	ArrayList<String> POSTagSent = new ArrayList<String>();
	int lengthDoc=0;
		
	class SentimentWordAttr{
		String word;
		Long offset;
		Double score;
		public Long getOffset() {
			return offset;
		}
		public void setOffset(Long offset) {
			this.offset = offset;
		}
		public Double getScore() {
			return score;
		}
		public void setScore(Double score) {
			this.score = score;
		}
		public String getWord() {
			return word;
		}
		public void setWord(String word) {
			this.word = word;
		}
		public String toString()
		{
			return "Word: " + word + " Offset: " + offset + " Score:" + score;
		}
	}



	public ArrayList<SentimentWordAttr> getNegWords() {
		return negWords;
	}

	public void setNegWords(ArrayList<SentimentWordAttr> negWords) {
		this.negWords = negWords;
	}

	public ArrayList<SentimentWordAttr> getPosWords() {
		return posWords;
	}

	public void setPosWords(ArrayList<SentimentWordAttr> posWords) {
		this.posWords = posWords;			
			
	}

	public ArrayList<String> getPOSTagSent() {
		return POSTagSent;
	}

	public void setPOSTagSent(ArrayList<String> posTagSent) {
		this.POSTagSent = posTagSent;
		}

	public ArrayList<String> getSentences() {
		return sentences;
	}

	public void setSentences(ArrayList<String> sentences) {
		this.sentences = sentences;
	}

	public ArrayList<Long> getSentSplitOffsets() {
		return sentSplitOffsets;
	}

	public void setSentSplitOffsets(ArrayList<Long> sentSplitOffsets) {
		this.sentSplitOffsets = sentSplitOffsets;
	}
	
	public int getLegthDoc() {
		return this.lengthDoc;
	}
	
	public void setLegthDoc(int len) {
		this.lengthDoc = len;
	}
	
}
