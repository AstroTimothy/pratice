package egovframework.example.sample.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.CmmtVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("cmmtDAO")
public class CmmtDAO extends EgovAbstractDAO {

	public String insertCmmt(CmmtVO vo) {
		return (String) insert("insertCmmt", vo);
	}

	
}
