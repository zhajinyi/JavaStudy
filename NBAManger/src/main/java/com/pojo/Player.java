package com.pojo;

import java.util.ArrayList;
import java.util.List;

public class Player {
	private int pid;
	private String pname;
	private int psex;
	private List<String> position=new ArrayList<String>();
	private Team team;
	
	public Player(){
		
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getPsex() {
		return psex;
	}

	public void setPsex(int psex) {
		this.psex = psex;
	}

	public List<String> getPosition() {
		return position;
	}

	public void setPosition(List<String> position) {
		this.position = position;
	}
	

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
	}

	@Override
	public String toString() {
		return "Player [pid=" + pid + ", pname=" + pname + ", psex=" + psex + ", position=" + position + ", team="
				+ team + "]";
	}
	
	
	

}
