package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ITeam;
import com.pojo.Team;
import com.service.ITeamService;
@Service
public class TeamService implements ITeamService {
	
	@Autowired
	ITeam teamdao;
	

	public ITeam getTeamdao() {
		return teamdao;
	}

	public void setTeamdao(ITeam teamdao) {
		this.teamdao = teamdao;
	}

	@Override
	public List<Team> getAllTeams() {
		// TODO Auto-generated method stub
		return teamdao.getAllTeams();
	}

	@Override
	public void addTeam(Team team) {
		teamdao.addTeam(team);

	}

}
