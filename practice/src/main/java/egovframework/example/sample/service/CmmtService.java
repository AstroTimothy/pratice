package egovframework.example.sample.service;

import java.util.List;
import java.util.Map;

public interface CmmtService {

//	댓글 등록
	public String insertCmmt(CmmtVO vo);

//	댓글 리스트
	public List<Map<String, String>> cmmtList(CmmtVO vo);

//	댓글 삭제
	public int cmmtDel(CmmtVO vo);

//	수정할 댓글 조회
	public List<CmmtVO> selectModiCmmt(CmmtVO vo);

}
