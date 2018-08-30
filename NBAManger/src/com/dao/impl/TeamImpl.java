package com.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dao.ITeam;
import com.pojo.Team;

@Repository
public class TeamImpl implements ITeam {

	@Autowired
	SessionFactory sessionFactory;
	

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}






	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}



	public Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	
	@Override
	public List<Team> getAllTeams() {
        Session session=getSession();
		
		Query query=session.createQuery("from Team");
		
		List<Team> teams=query.list();
		
		return teams;
	}

	@Override
	public void addTeam(Team team) {
		 Session session=getSession();
		 session.save(team);

	}

}
