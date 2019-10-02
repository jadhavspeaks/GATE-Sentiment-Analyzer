package com.sentimentanalysis;
import gate.Annotation;

import java.util.Vector;

@SuppressWarnings("serial")
public  class SortedAnnotationList extends Vector {
	    public SortedAnnotationList() {
	    	super();
	    } 
	
	    @SuppressWarnings("unchecked")
		public boolean addSortedExclusive(Annotation annot) {
	    	Annotation currAnot = null;
	
	    	// overlapping check
	    	for (int i=0; i<size(); ++i) {
	    		currAnot = (Annotation) get(i);
	    	    if(annot.overlaps(currAnot)) {
	    	    	return false;
	    	    } 
	    	} 
	
	    	long annotStart = annot.getStartNode().getOffset().longValue();
	    	long currStart;
	    	// insert
	    	for (int i=0; i < size(); ++i) {
	    		currAnot = (Annotation) get(i);
	    		currStart = currAnot.getStartNode().getOffset().longValue();
	    		if(annotStart < currStart) {
	    			insertElementAt(annot, i);
	    			return true;
	    		} 
	    	}
	    	int size = size();
	    	insertElementAt(annot, size);
	    	return true;
	    }
 } 
