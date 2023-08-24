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
   comment_count INT DEFAULT 0
);
*/
/*
DELIMITER //
CREATE PROCEDURE replyAndUpdate(IN bno INT, IN title VARCHAR(50), IN writer VARCHAR(10), IN content TEXT, IN password VARCHAR(15), IN depth INT)
BEGIN
   DECLARE groupNo INT;
   DECLARE curStep INT;
   SET groupNo = (SELECT group_no FROM board WHERE bno = bno);
   SET curStep = (SELECT step FROM board WHERE bno = bno);
   
   -- UPDATE 작업
   UPDATE board
   SET step = step + 1
   WHERE group_no = groupNo AND step > curStep;
   
   -- INSERT 작업
   INSERT INTO board
   (title, writer, content, password, group_no, step, depth)
   VALUES
   (title, writer, content, password, groupNo, curStep + 1, depth);
END //
DELIMITER ;*/

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
	
	@Builder.Default
	private int commentCnt = 0;
}
