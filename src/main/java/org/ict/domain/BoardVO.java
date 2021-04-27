package org.ict.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String writer;
	private String content;
	private Date regdate;
	private Date updatedate;
	
}
