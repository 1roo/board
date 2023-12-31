package com.spring.board.command;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE board(
   bno INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(50) NOT NULL,
   writer VARCHAR(10) NOT NULL,
   password VARCHAR(15) NOT NULL,
   content VARCHAR(500) NOT NULL,
   group_no INT NOT NULL DEFAULT 0,
   step INT NOT NULL DEFAULT 0,
   depth INT NOT NULL DEFAULT 0,
   create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   update_date DATETIME DEFAULT NULL,
   comment_count INT DEFAULT 0,
   baby_count INT DEFAULT 0,
   del INT DEFAULT 0
);
*/

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardVO {
	private int bno;
	private String title;
	private String writer;
	private String password;
	private String content;
	private LocalDateTime createDate;
	private LocalDateTime updateDate;
	
	private int groupNo;
	private int step;
	private int depth;
	
	private int group_no; 
	
	private int commentCount;
	private int babyCount;
	private int del;
}
