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
		String sql = "select num, title, content, id, visitcount"
				+ "				, decode(trunc(sysdate)"
				+ "				, trunc(postdate)"
				+ "				, to_char(postdate, 'hh24:mi:ss')"
				+ "				, to_char(postdate, 'yyyy-mm-dd'))  postdate "
				+ "     from board ";
		
		// 검색어가 입력 된경우 검색조건을 추가 합니다
		if(criteria.getSearchWord() != null
				&& !"".equals(criteria.getSearchWord())) {
			sql += "where "+criteria.getSearchField()
						+" like '%"+criteria.getSearchWord()+"%'";
		}
		
		sql += " order by num desc";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setNum(rs.getString("num"));
				board.setPostdate(rs.getString("postdate"));
				board.setTitle(rs.getString("title"));
				board.setVisitcount(rs.getString("visitcount"));
				
				list.add(board);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	public List<Board> getListPage(Criteria criteria){
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
	
	public int insert(Board board) {
		int res = 0;
		String sql = "insert into board "
				+ "values (seq_board_num.nextval, ?, ?, ?, sysdate, 0)";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			
			psmt.setString(1, board.getTitle());
			psmt.setString(2, board.getContent());
			psmt.setString(3, board.getId());
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	public Board selectOne(String num) {
		String sql = "select * from board where num = ?";
		Board board = null;
		
		System.out.println("num : "+num);
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setString(1, num);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				board = new Board();
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setNum(rs.getString("num"));
				board.setPostdate(rs.getString("postdate"));
				board.setTitle(rs.getString("title"));
				board.setVisitcount(rs.getString("visitcount"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return board;
	}
	
	public void updateVisitCount(String num) {
		String sql = "update board set visitcount = visitcount+1 where num=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			
			psmt.setString(1, num);
			psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 게시물의 총 갯수를 반환합니다.
	 * @return 게시물의 총 갯수
	 */
	public int getTotalCnt(Criteria criteria) {
		int res = 0;
		String sql = "select count(*) from board ";
		if(criteria.getSearchWord() != null 
				&& !"".equals(criteria.getSearchWord())) {
			sql += "where "+criteria.getSearchField()
					+" = '%"+criteria.getSearchWord() +"%'";
		}	
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				res = rs.getInt(1); // 첫번째 컬럼의 값을 반환			
			}
			
			rs.close();
		} catch (SQLException e) {
			System.out.println("총 게시물의 수를 조회 하던중 예외가 발생 하였습니다.");
			e.printStackTrace();
		}
		
		return res;
	}
}
