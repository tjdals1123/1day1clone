package org.ict.domain;

import lombok.Data;

@Data
public class Criteria {

	private int page;
	private int number;
	
	public Criteria() {
		
		page = 1;
		number = 10;
	}
	
	public int getPageStart() {
		return (this.page -1) * number;
	}
}
