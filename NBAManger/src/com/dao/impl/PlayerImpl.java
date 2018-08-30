package com.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dao.IPlayer;
import com.pojo.Player;

@Repository
public class PlayerImpl implements IPlayer {
	
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
	public void addplayer(Player player) {
		

		Session session=getSession();
	
		session.save(player);
	}

	@Override
	public void deleteplayer(int pid) {
		
        Session session=getSession();
		Player player=(Player) session.get(Player.class, pid);
		session.delete(player);
		
		
	}

	@Override
	public void updateplayer(Player player) {

		Session session=getSession();
		session.update(player);
	}

	@Override
	public List<Player> getAllplayer() {
		Session session=getSession();
		Query query=session.createQuery("from Player p left join fetch p.team");
		List<Player> players=query.list();
	
		return players;
	}

	@Override
	public Player getByid(int pid) {
		Session session=getSession();
		Player player=(Player) session.get(Player.class, pid);
		
		return player;
	}

}
