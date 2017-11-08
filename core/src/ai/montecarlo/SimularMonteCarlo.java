package ai.montecarlo;

public class SimularMonteCarlo {

	public static void main(String[] args) {
		MonteCarloTreeSearch mcts = new MonteCarloTreeSearch(1,null,50);
		mcts.run();

	}

}
