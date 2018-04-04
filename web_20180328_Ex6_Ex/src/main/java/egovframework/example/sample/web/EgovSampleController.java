/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class EgovSampleController {

	/** EgovSampleService
	 * 서비스를 지정 */
	@Resource(name = "sampleService")
	private EgovSampleService sampleService;

	/** EgovPropertyService
	 * propertiesService에서 페이징처리 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator
	 * 유효성검사 */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/egovSampleList.do")
	//클래스명에 sql
	public String selectSampleList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = sampleService.selectSampleList(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sample/egovSampleList";
	}

	/**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.GET)
	public String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		model.addAttribute("sampleVO", new SampleVO());
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 * 파일을 업로드 한다.
	 * @param request
	 * @return List<String> 파일명리스트 
	 * @throws Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.POST)
	public String addSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, 
			BindingResult bindingResult, Model model, SessionStatus status, HttpServletRequest request)
			throws Exception {

		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

		// extract files
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		// process files
		String uploadLastPath = "image";
		String uploadPath = request.getSession().getServletContext().getRealPath("/") + uploadLastPath;
		File saveFolder = new File(uploadPath);
		String fileName = null;
		List<String> result = new ArrayList<String>();
		// 디렉토리 생성
		boolean isDir = false;

		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}

		if (!isDir) {

			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;
			String filePath;

			while (itr.hasNext()) {
				
				//파일 생성
				Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				fileName = file.getOriginalFilename();
				if (!"".equals(fileName)) {

					// 파일 전송
					filePath = uploadPath + "\\" + fileName;
					file.transferTo(new File(filePath));
					result.add(fileName);
				}
			}
		}
		
		// Server-Side Validation
		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.insertSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();
		sampleVO.setId(id);
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute(selectSample(sampleVO, searchVO));
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	public SampleVO selectSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return sampleService.selectSample(sampleVO);
	}

	/**
	 * 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateSample.do")
	public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.updateSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteSample.do")
	public String deleteSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {
		sampleService.deleteSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}
	
	/**
	 * 비밀번호를 입력한다.
	 */
	@RequestMapping("/passwordSampleView.do")
	public String passwordSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, Model model, @RequestParam("selectedId") String id) throws Exception {
		model.addAttribute("id", id);
		model.addAttribute("sampleVO", new SampleVO());
		
		return "sample/egovSamplePassword";
	}
		
	/**
	 * 비밀번호를 확인한다.
	 */
	@RequestMapping(value = "/passwordSample.do", method=RequestMethod.POST)
	public String selectPasswordCnt(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, Model model, @RequestParam("selectedId") String id) throws Exception {
		model.addAttribute("sampleVO", new SampleVO());
		model.addAttribute("selectedId", id);
		
		sampleVO.setId(id);
		
		int chk = 0;
		chk = sampleService.selectPasswordCnt(sampleVO);
				
		String url = "forward:/egovSampleList.do";
		if(chk == 1){
			url = "forward:/updateSampleView.do";
		}
		
		return  url;
	}

	
	/**
	 * 댓글을 생성.
	 */
	
	@RequestMapping(value ="/commentSample.do")
	@ResponseBody
	public void insertCMinsert(SampleVO sampleVO)throws Exception {
		String chk = sampleService.insertComment(sampleVO);
		
	}
	
	@RequestMapping(value ="/commentList.do")
	@ResponseBody
	public ModelAndView selectCommentList(SampleVO sampleVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("jsonView");

		List commnetList = sampleService.insertCommentList(sampleVO);
		System.out.println(commnetList.get(0)+"sssss");
		
		mav.addObject("commnetList",commnetList);
		
		
		return mav;
		
	}
	
	/**
	 * 댓글을 삭제한다.
	 */
	@RequestMapping(value ="/commentDelete.do")
	@ResponseBody
	public void deleteCM(SampleVO sampleVO)throws Exception {

		
		System.out.println("삭제시작");
		
	}
	

	
	
	
	
	
	
	
	
	
	
	

}