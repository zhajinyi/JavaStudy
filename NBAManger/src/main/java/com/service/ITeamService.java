package com.service;

import java.util.List;

import com.pojo.Team;

public interface ITeamService {
public List<Team> getAllTeams();
	
	public void addTeam(Team team);

}
