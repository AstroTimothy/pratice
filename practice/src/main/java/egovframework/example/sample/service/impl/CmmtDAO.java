package egovframework.example.sample.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.CmmtVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("cmmtDAO")
public class CmmtDAO extends EgovAbstractDAO {

	public String insertCmmt(CmmtVO vo) {
		return (String) insert("insertCmmt", vo);
	}

	public List<Map<String, String>> cmmtList(CmmtVO vo) {
		return (List<Map<String, String>>) list("cmmtList", vo);
	}

	public int cmmtDel(CmmtVO vo) {
		return update("cmmtDel", vo);
	}

	public List<CmmtVO> selectModiCmmt(CmmtVO vo) {
		return (List<CmmtVO>) list("selectModiCmmt", vo);
	}

	
}
