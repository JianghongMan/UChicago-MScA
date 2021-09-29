# Twitter NLP Sentiment Analysis  

- EDA

- Topic Modeling 
  - Text Cleaning
    - Drop duplicates as people often retweet on Twitter
    - Convert all text to lowercases
    - Result: Move from long text with numbers, hashtags, links, etc. to tokenized lists of words
  - Latent Dirichlet Allocation (LDA)
    - Derive bigrams and do some text normalization like lemmatization and stemming to further clean up 
    - Built a model using LDA in order to assign a dominant topic to each tweet
    - Result: Extracted the top 10 words. topic 1 is about staying home, topic 2 is about the protest, and topic 3 is about the number of death
  
- Sentiment Analysis

- Giveaways:

  - Although people tend to have a negative attitude towards covid in general, especially towards the riots and death cases related to it, they also tend to show positive sentiment towards policy-related tweets. A relatively large proportion of people are tweeting positively about the staying at home policy. 
  - Some tweets are not about covid. Although covid is an ongoing long-term event, people’s discussion is also strongly impacted by and related to other big real-time events such as the black lives matter event.
 


