package com.service;

import java.util.List;

import com.pojo.Player;

public interface IPlayerService {
public void addplayer(Player player);
	
	public void deleteplayer(int pid);
	
	public void updateplayer(Player player);
	
	public List<Player> getAllplayer();
	
	public Player getByid(int pid);


}
