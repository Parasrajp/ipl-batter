-- Step 1: Create the database
CREATE DATABASE IPL;

-- Step 2: Select the database
USE IPL;

-- Step 3: Create the table
CREATE TABLE ipl_batter (
    Player_Name VARCHAR(50) PRIMARY KEY,
    Team VARCHAR(50),
    Runs INT,
    Matches INT,
    Inning INT,
    HS FLOAT,
    Average FLOAT,
    SR FLOAT,
    ton INT,
    fifty INT,
    fours INT,
    sixs INT
);
 
 SELECT * FROM ipl_batter;
 
 -- Q1 = Total number of players in the IPL_batter table

 SELECT COUNT(*) AS total_players FROM ipl_batter;
 
 -- Q2 = List all players who scored more than 500 runs
 
 SELECT Player_Name,Team,Runs FROM ipl_batter WHERE Runs > 500; 
 
 -- Q3 = Find players with average above 40
 
 SELECT Player_Name,Team,Average FROM ipl_batter WHERE Average > 40 ORDER BY Average DESC;
 
 -- Q4 = Show top 5 players by strike rate (SR)
 
 SELECT Player_Name,Team,SR FROM ipl_batter ORDER BY SR DESC LIMIT 5;
 
 -- Q5 = Count how many players belongs to each team
 
 SELECT Team,COUNT(*) player_count FROM ipl_batter GROUP BY Team ORDER BY player_count DESC;
 
 -- Q6 = Find the player(s) with the highest individual score (HS)
 
   SELECT Player_Name,Team,HS FROM ipl_batter ORDER BY HS DESC LIMIT 1;

-- Q7 = Calculate total runs scored by each team

 SELECT Team,SUM(Runs) AS total_run FROM ipl_batter GROUP BY Team ORDER BY total_run DESC;
 
 -- Q8 = Find top 5 players with the most centuries (Hundreds)
 
 SELECT Player_Name,Team,ton FROM ipl_batter ORDER BY ton DESC LIMIT 5;
 
 -- Q9 = Find players who hit more sixes than fours
 
 SELECT Player_Name,team,fours,sixs FROM ipl_batter WHERE sixs > fours;
 
 -- Q10 = Find players with the best consistency (highest average per inning)
 
 SELECT Player_Name, Team, (Runs / Inning) AS runs_per_inning 
FROM ipl_batter 
ORDER BY runs_per_inning DESC 
LIMIT 10;

-- Q11 = Find team-wise average strike rate and batting average

SELECT 
    Team, 
    ROUND(AVG(SR), 2) AS avg_strike_rate,
    ROUND(AVG(Average), 2) AS avg_batting_avg
FROM ipl_batter
GROUP BY Team
ORDER BY avg_batting_avg DESC;

-- Q12 = Find players who contribute more than 20% of their team’s total runs

SELECT 
    b.Player_Name,
    b.Team,
    b.Runs,
    ROUND((b.Runs / t.team_runs) * 100, 2) AS contribution_percent
FROM IPL_batter b
JOIN (
    SELECT Team, SUM(Runs) AS team_runs FROM ipl_batter GROUP BY Team
) t ON b.Team = t.Team
WHERE (b.Runs / t.team_runs) * 100 > 20
ORDER BY contribution_percent DESC;


-- Q13 = Rank players by their runs within each team

SELECT 
    Player_Name, 
    Team, 
    Runs,
    RANK() OVER (PARTITION BY Team ORDER BY Runs DESC) AS team_rank
FROM ipl_batter;

-- Q14 = Find the most aggressive players (Strike rate above 150 and Average above 30)

SELECT Player_Name, Team, SR, Average 
FROM ipl_batter 
WHERE SR > 150 AND Average > 30 
ORDER BY SR DESC;

-- Q15 = Find correlation between average and strike rate (using SQL trend analysis idea)

SELECT 
    CASE 
        WHEN SR > 140 AND Average > 35 THEN 'Elite Batter'
        WHEN SR BETWEEN 120 AND 140 AND Average BETWEEN 25 AND 35 THEN 'Balanced Player'
        ELSE 'Needs Improvement'
    END AS Performance_Category,
    COUNT(*) AS player_count
FROM ipl_batter
GROUP BY Performance_Category;

