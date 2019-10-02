package com.sentimentanalysis;

import java.util.ArrayList;
import java.util.HashMap;

public class SentenceObj {
	public String content = new String();
	public Integer startOffset;
	public Integer endOffset;
	public HashMap<Integer,String> tokenVsPOSmap = new HashMap<Integer,String>();
	public String sentencePOSStr = new String(); 
	public ArrayList<ClauseObj> clauses = new ArrayList<ClauseObj>();
	
	
}
