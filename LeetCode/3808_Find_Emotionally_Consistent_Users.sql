WITH UserReactionTally AS (
    -- Step 1: Crush the data into buckets by user AND specific reaction type
    SELECT 
        user_id,
        reaction,
        COUNT(*) AS specific_reaction_count
    FROM reactions
    GROUP BY user_id, reaction
),
RankedReactions AS (
    -- Step 2: Calculate the total reactions per user and rank the most frequent one
    SELECT 
        user_id,
        reaction AS dominant_reaction,
        specific_reaction_count,
        SUM(specific_reaction_count) OVER(PARTITION BY user_id) AS total_reactions,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY specific_reaction_count DESC) AS rnk
    FROM UserReactionTally
)
-- Step 3: Filter for the dominant reaction, apply the threshold rules, and calculate ratio
SELECT 
    user_id,
    dominant_reaction,
    ROUND(specific_reaction_count / total_reactions, 2) AS reaction_ratio
FROM RankedReactions
WHERE rnk = 1 
  AND total_reactions >= 5 
  AND (specific_reaction_count / total_reactions) >= 0.60
ORDER BY reaction_ratio DESC, user_id ASC;