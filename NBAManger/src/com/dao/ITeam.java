package com.dao;

import java.util.List;

import com.pojo.Team;

public interface ITeam {
	
	public List<Team> getAllTeams();
	
	public void addTeam(Team team);

}
