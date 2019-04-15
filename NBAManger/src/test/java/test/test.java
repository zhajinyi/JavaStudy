package test;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.dao.impl.TeamImpl;
import com.pojo.Team;

public class test {

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void test() {
		TeamImpl ti=new TeamImpl();
	    Team team=new Team(1,"»ð¼ý");
		ti.addTeam(team);
	}

}
