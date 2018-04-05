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
package egovframework.example.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.CmmtService;
import egovframework.example.sample.service.CmmtVO;

@Service("cmmtService")
public class CmmtServiceImpl implements CmmtService {

	@Resource(name = "cmmtDAO")
	private CmmtDAO dao;
	
//	댓글 등록
	@Override
	public String insertCmmt(CmmtVO vo) {
		return dao.insertCmmt(vo);
	}

//	댓글 리스트
	@Override
	public List<Map<String, String>> cmmtList(CmmtVO vo) {
		return dao.cmmtList(vo);
	}

//	댓글 삭제
	@Override
	public int cmmtDel(CmmtVO vo) {
		return dao.cmmtDel(vo);
	}

//	수정할 댓글 조회
	@Override
	public List<CmmtVO> selectModiCmmt(CmmtVO vo) {
		return dao.selectModiCmmt(vo);
	}

}
