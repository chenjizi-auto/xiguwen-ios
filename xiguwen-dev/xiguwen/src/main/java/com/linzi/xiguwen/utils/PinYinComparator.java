package com.linzi.xiguwen.utils;

import com.linzi.xiguwen.bean.SortModel_A;

import java.util.Comparator;

public class PinYinComparator implements Comparator<SortModel_A> {

	/**
	 * 排序比较
	 */
	@Override
	public int compare(SortModel_A lhs, SortModel_A rhs) {
		return lhs.getSortLetter().compareTo(rhs.getSortLetter());
	}
}
