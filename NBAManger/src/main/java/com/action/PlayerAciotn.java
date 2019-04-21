package com.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Player;
import com.pojo.Team;
import com.service.IPlayerService;
import com.service.ITeamService;
@Controller
@Scope("prototype")
public class PlayerAciotn implements ModelDriven<Player>,ServletRequestAware{

	@Autowired
	IPlayerService playerservice;
	
	@Autowired
	ITeamService teamservice;
	
    Player player;
	HttpServletRequest request;
	
	
	public IPlayerService getPlayerservice() {
		return playerservice;
	}

	public void setPlayerservice(IPlayerService playerservice) {
		this.playerservice = playerservice;
	}

	public ITeamService getTeamservice() {
		return teamservice;
	}

	public void setTeamservice(ITeamService teamservice) {
		this.teamservice = teamservice;
	}

	

	
	
	public String addInit(){
		
		List<Team> teams=teamservice.getAllTeams();
		
		Map<String,Object> request=(Map<String, Object>) ActionContext.getContext().get("request");
		
		request.put("teams", teams);
		
		return "add";
		
	}
	
	public String add(){
		
		playerservice.addplayer(player);
		
		return "success";
		
	}
	
	public String delete(){
		
		int pid=player.getPid();
		playerservice.deleteplayer(pid);
		
		return "success";
		
	}
	
	public String updateInit(){
		
		int pid=(Integer) request.getAttribute("pid");
		Player player=playerservice.getByid(pid);
		request.setAttribute("player", player);
		
        List<Team> teams=teamservice.getAllTeams();
		
		Map<String,Object> request=(Map<String, Object>) ActionContext.getContext().get("request");
		
		request.put("teams", teams);
		return "update";
		
	}
	
	public String update(){
		
		
		playerservice.updateplayer(player);
		
		
		return "success";
		
	}
	public String list(){
		
		List<Player> players=playerservice.getAllplayer();
		
		request.setAttribute("players", players);
		return "list";
		
	}

	@Override
	public Player getModel() {
		
		if(player==null){
			player=new Player();
		}
		// TODO Auto-generated method stub
		return player;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}

}
