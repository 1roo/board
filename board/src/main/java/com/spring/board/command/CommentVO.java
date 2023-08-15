package com.spring.board.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


/*
CREATE TABLE comment(
	cno INT PRIMARY KEY AUTO_INCREMENT,
    bno INT,
	FOREIGN KEY (bno) 
	REFERENCES board(bno)
    ON DELETE CASCADE,
   
   comment VARCHAR(500),
   comment_writer VARCHAR(10),
   comment_pw VARCHAR(15),
   create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   update_date DATETIME DEFAULT NULL
);
*/


@Getter @Setter @ToString
public class CommentVO {

	private int cno;
	private int bno;
	
	private String comment;
	private String commentWriter;
	private String commentPw;
	private LocalDateTime createDate;
	private LocalDateTime updateDate;
	
	
}
