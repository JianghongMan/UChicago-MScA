# Assignment 6 - Recommender System

This project aims to:

1. Recommend 10 songs to users who have listened to 'u2' and 'pink floyd'. Use item-item collaborative filtering to find songs that are similar using spatial distance with cosine. 

2. Find user most similar to user 1606. Use user-user collaborative filtering with cosine similarity. List the recommended songs for user 1606 

3. How many of the recommended songs has already been listened to by user 1606?

4. Use a combination of user-item approach to build a recommendation score for each song for each user using the following steps for each user-

  -- For each song for the user row, get the top 10 similar songs and their similarity score.
  -- For each of the top 10 similar songs, get a list of the user purchases
  -- Calculate a recommendation score 
  -- What are the top 5 song recommendations for user 1606?

Dataset: radio_songs.csv
