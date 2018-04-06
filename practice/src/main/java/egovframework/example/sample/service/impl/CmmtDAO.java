package egovframework.example.sample.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.CmmtVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("cmmtDAO")
public class CmmtDAO extends EgovAbstractDAO {

//	댓글 입력
	public String insertCmmt(CmmtVO vo) {
		return (String) insert("insertCmmt", vo);
	}

//	댓글 목록
	public List<Map<String, String>> cmmtList(CmmtVO vo) {
		return (List<Map<String, String>>) list("cmmtList", vo);
	}

//	댓글 삭제
	public int cmmtDel(CmmtVO vo) {
		return update("cmmtDel", vo);
	}

//	수정할 댓글 조회
	public List<Map<String, String>> selectModiCmmt(CmmtVO vo) {
		return (List<Map<String, String>>) list("selectModiCmmt", vo);
	}

	
}
