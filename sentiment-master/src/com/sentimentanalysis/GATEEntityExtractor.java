package com.sentimentanalysis;

import gate.Annotation;
import gate.Corpus;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;
import gate.util.Out;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

public class GATEEntityExtractor {

	public static ArrayList<SentenceObj> arrOfSentObj = new ArrayList<SentenceObj>();
	public static HashMap<Integer, HashMap<Integer, String>> mapOfSentsStructures = new HashMap<Integer, HashMap<Integer, String>>();
	public static HashMap<Integer, SentenceObj> mapOfSents = new HashMap<Integer, SentenceObj>();

	private static GATEEntityExtractor annie = new GATEEntityExtractor();

	private SerialAnalyserController annieController;

	
	/** Tell ANNIE's controller about the corpus you want to run on */
	public void setCorpus(Corpus corpus) {
		annieController.setCorpus(corpus);
	} // setCorpus

	/** Run ANNIE */
	public void execute() throws GateException {
		Out.prln("Running ANNIE...");
		annieController.execute();
		Out.prln("...ANNIE complete");
	} // execute()



	public static class SortedAnnotationList extends Vector {
		public SortedAnnotationList() {
			super();
		} // SortedAnnotationList

		public boolean addSortedExclusive(Annotation annot) {
			Annotation currAnot = null;

			// overlapping check
			for (int i = 0; i < size(); ++i) {
				currAnot = (Annotation) get(i);

				// Modified the if condition below
				if (annot.overlaps(currAnot) && annot.getType().equals(currAnot.getType())) {
					return false;

				} // if
			} // for

			long annotStart = annot.getStartNode().getOffset().longValue();
			long currStart;
			// insert
			for (int i = 0; i < size(); ++i) {
				currAnot = (Annotation) get(i);
				currStart = currAnot.getStartNode().getOffset().longValue();
				if (annotStart < currStart) {
					insertElementAt(annot, i);
					return true;
				} // if
			} // for

			int size = size();
			insertElementAt(annot, size);
			return true;
		} // addSorted
	} // SortedAnnotationList
}