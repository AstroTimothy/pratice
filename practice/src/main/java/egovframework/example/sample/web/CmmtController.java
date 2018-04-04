package egovframework.example.sample.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.CmmtService;
import egovframework.example.sample.service.CmmtVO;


@Controller
@RequestMapping("/practice")
public class CmmtController {
	
	@Resource(name="cmmtService")
	private CmmtService cmmtService;

//	댓글 등록
	@RequestMapping(value="/cmmtInsert.do")
	@ResponseBody
	public String insertCmmt(CmmtVO vo) throws Exception {
		
		cmmtService.insertCmmt(vo);	
		
		return "";
	}
	
//  댓글 리스트 출력
	@RequestMapping(value="/cmmtList.do")
	@ResponseBody
	public String cmmtList(CmmtVO vo){
		
		cmmtService.cmmtList(vo);
		
		return null;
	}
	
	

}
