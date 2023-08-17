package com.spring.board.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE board(
   bno INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(50) NOT NULL,
   writer VARCHAR(10) NOT NULL,
   password VARCHAR(15) NOT NULL,
   content VARCHAR(500) NOT NULL,
   group_no INT NOT NULL,
   group_ord INT NOT NULL,
   depth INT NOT NULL,
   create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   update_date DATETIME DEFAULT NULL
);
*/

@Getter
@Setter
@ToString
public class BoardVO {
	private int bno;
	private String title;
	private String writer;
	private String password;
	private String content;
	private LocalDateTime createDate;
	private LocalDateTime updateDate;
	
	private int groupNo;
	private int groupOrd;
	private int depth;
	
	private int commentCnt;
}
