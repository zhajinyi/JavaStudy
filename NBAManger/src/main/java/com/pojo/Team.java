package com.pojo;

import java.util.Set;

public class Team {
	private Integer tid;
	private String tname;
	private Set<Player> players;
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public Set<Player> getPlayers() {
		return players;
	}
	public void setPlayers(Set<Player> players) {
		this.players = players;
	}
	public Team(Integer tid, String tname) {
		super();
		this.tid = tid;
		this.tname = tname;
	}
	
	
	public Team(){
		
	}
	

}
