package egovframework.example.sample.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView cmmtList(CmmtVO vo){
		
		List<Map<String, String>> cmmtList = cmmtService.cmmtList(vo);

		ModelAndView mav = new ModelAndView();
		mav.addObject("cmmtList", cmmtList);
		
		return mav;
	}
	
	

}
