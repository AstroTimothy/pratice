
package egovframework.example.sample.service;

public class CmmtVO {
	
//	글 id
	private String id;	
	
//	댓글 id
	private String cmmt_id;	
	
//	댓글 작성자 이름
	private String cmmt_name;
	
//	댓글 내용
	private String cmmt_contents;
	
//	댓글 비밀번호
	private String cmmt_pwd;

//	댓글 작성시간
	private String cmmt_wtime;

//	삭제 여부
	private String del_yn;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCmmt_id() {
		return cmmt_id;
	}

	public void setCmmt_id(String cmmt_id) {
		this.cmmt_id = cmmt_id;
	}

	public String getCmmt_name() {
		return cmmt_name;
	}

	public void setCmmt_name(String cmmt_name) {
		this.cmmt_name = cmmt_name;
	}

	public String getCmmt_contents() {
		return cmmt_contents;
	}

	public void setCmmt_contents(String cmmt_contents) {
		this.cmmt_contents = cmmt_contents;
	}

	public String getCmmt_pwd() {
		return cmmt_pwd;
	}

	public void setCmmt_pwd(String cmmt_pwd) {
		this.cmmt_pwd = cmmt_pwd;
	}

	public String getCmmt_wtime() {
		return cmmt_wtime;
	}

	public void setCmmt_wtime(String cmmt_wtime) {
		this.cmmt_wtime = cmmt_wtime;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	
}
