package egovframework.example.sample.service;

import java.util.List;
import java.util.Map;

public interface CmmtService {

//	댓글 등록
	public String insertCmmt(CmmtVO vo);

//	댓글 리스트
	public List<Map<String, String>> cmmtList(CmmtVO vo);

}
