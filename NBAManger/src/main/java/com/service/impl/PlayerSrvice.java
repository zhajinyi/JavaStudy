package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.IPlayer;
import com.pojo.Player;
import com.service.IPlayerService;
@Service
public class PlayerSrvice implements IPlayerService {
	@Autowired
	IPlayer plyaerdao;
	

	public IPlayer getPlyaerdao() {
		return plyaerdao;
	}

	public void setPlyaerdao(IPlayer plyaerdao) {
		this.plyaerdao = plyaerdao;
	}

	@Override
	public void addplayer(Player player) {
		// TODO Auto-generated method stub
		plyaerdao.addplayer(player);
	}

	@Override
	public void deleteplayer(int pid) {
		// TODO Auto-generated method stub
		plyaerdao.deleteplayer(pid);
	}

	@Override
	public void updateplayer(Player player) {
		// TODO Auto-generated method stub
		plyaerdao.updateplayer(player);
	}

	@Override
	public List<Player> getAllplayer() {
		// TODO Auto-generated method stub
		return plyaerdao.getAllplayer();
	}

	@Override
	public Player getByid(int pid) {
		// TODO Auto-generated method stub
		return plyaerdao.getByid(pid);
	}

}
