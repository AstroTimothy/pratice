package egovframework.example.sample.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.sample.service.CmmtService;
import egovframework.example.sample.service.CmmtVO;


@Controller
@RequestMapping("/practice")
public class CmmtController {
	
	@Resource(name="cmmtService")
	private CmmtService cmmtService;

//	댓글 등록
	@RequestMapping("/cmmt_insert.do")
	public String insertCmmt(CmmtVO vo) throws Exception {
		
		cmmtService.insertCmmt(vo);	
		
		return "practice/updateSampleView";
	}
	
//  댓글 리스트 출력
//	@RequestMapping("cmmtList.do")
//	public ModelAndView  cmmtList(){
//		
//	}
//	
	

}
