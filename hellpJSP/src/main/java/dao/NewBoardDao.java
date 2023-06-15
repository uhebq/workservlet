package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.Board;
import dto.Criteria;

public class NewBoardDao {
	
	public NewBoardDao() {
		
	}
	
	public List<Board> getList(Criteria criteria){
		List<Board> list = new ArrayList<>();
		
		String sql = 
				"select * from ("
				+ "	select rownum rn, t.* from ("
				+ "		select num, title, content, id, visitcount"
				+ "    		, decode(trunc(sysdate)"
				+ "			, trunc(postdate)"
				+ "     	, to_char(postdate, 'hh24:mi:ss')"
				+ "     	, to_char(postdate, 'yyyy-mm-dd')) postdate"
				+ "		from board";
		
		// 검색어가 입력된 경우 검색조건을 추가합니다.
		if(criteria.getSearchWord() != null
				&& !"".equals(criteria.getSearchWord())) {
			sql += "where " + criteria.getSearchField()
						+" like '%" + criteria.getSearchWord()+"%'";
		}
		sql += " order by num desc"
				+ "		)t"
				+ ")"
				+ "where rn between "
				+ criteria.getStartNo()
				+ " and "
				+ criteria.getEndNo();
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			ResultSet rs = psmt.executeQuery();
			
			// System.out.println(sql);
			
		while(rs.next()) {	
			Board board = new Board();
			board.setNum(rs.getString("num"));
			board.setTitle(rs.getString("title"));
			board.setContent(rs.getString("content"));
			board.setId(rs.getString("id"));
			board.setPostdate(rs.getString("postdate"));
			board.setVisitcount(rs.getString("visitcount"));
			
			list.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
}
