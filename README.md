					Contents

•	myPersonality Dataset.

•	Few noticeable contributions made using this dataset:

•	How does input attributes in myPersonality dataset affect the user personality.

•	Multi-label classification

•	Statistical Analysis.




















myPersonality dataset:
This dataset was prepared in a workshop conducted in 2013, main purpose was to use it as a benchmark in predicting the personality of an individual based on his/her Facebook statuses and social network features. 
Personality of an individual is categorized into big5 personality traits, which includes 
1)Extraversion(x) (sociable vs shy) 
2)Neuroticism(n) (neurotic vs calm) 
3)Agreeableness(a) (friendly vs uncooperative) 
4)Conscientiousness(c) (organized vs careless) 
5)Openness(o) (insightful vs unimaginative).

Dataset having information about 250 Facebook users’, 9918 records, Facebook statuses in raw texts & network features (network size, betweenness centrality, density, brokerage and transitivity) as independent variables.

Density: This attribute can be calculated for a network to compute density of relation between nodes.
Brokerage: Brokerage is the number of connected neighbors’ pairs that the individual does not directly connect with.
Betweenness: It indicates the number of shortest connected paths between pairs via each individual.
Transitivity: Transitive triad is based on “friends of my friends are also my friends” idea.

These 250 users were made to answer 100 item long version of IPIP questioners, this yielded big5 personality values and its used as dependent variable. (Truth). 
Need to develop models that provides best accuracy for the truth with the existing independent variables.












Few noticeable contributions made using this dataset:
1.	Gosling et al. [28] According to their research upon the dataset, extraverts are more willing to use social media to socialize themselves in the society. Another supporting claim is that people high in openness use social media to explore new activities. They frequently change their profile pictures compared to other users.
2.	Farnadi et al. proposed a model which uses LIWC features, social network features and temporal features. According to their results, users high in extraversion and conscientiousness have more friends compared to other users.
3.	Markovikj et al. In his study used couple of features to extract raw text using LIWC Tool, POS Tagger, Affin Dictionary and General Inquirer Tool (H4Lvd Dictionary). In addition, they have used demographic and egocentric network data & using Sequential Minimal Optimization (SMO) classification algorithm, they claim that prediction performance can be improved at a 0.8 – 0.9 true positive rate.
4.	Alam et al. Tested the dataset using couple of classifiers such as (Sequential Minimal Optimization for Support Vector Machine, Bayesian Logistic Regression and Multinomial Naïve Bayes) and they claim that Multinomial Naïve Bayes sparse model perform better results compare to other models.  
5.	To analyze the effects of personality traits on friendships, researchers have used Simulation Investigation for Empirical Network Analyses (SIENA) tool. Their results show that individuals high in extraversion make new friends easily. They usually have large friendship networks. In addition, individuals high in agreeableness are easy to get along with others, therefore they are chosen as friends by others and they also have large friendship networks.
6.	One of the major problem in prediction is over fitting, a model builds in one dataset show up very poor accuracy in another. To overcome this problem, algorithm uses parameter estimations, domain weighting, and linear transformations to correct the domain bias.

How does input attributes in myPersonality dataset affect the user personality
Here, basically I mention how the data preprocessing task is carried out. In this dataset the valuable input are the status updates (which’s in raw text) and the social network features. 
Status updates: We cannot use this information directly in processing it needs to be broken down, goal is to extract linguistic features from the text. There are several linguistic processing tools such as LIWC Tool, POS Tagger, Affin Dictionary and General Inquirer Tool (H4Lvd Dictionary), NRC emotion Lexicon. So, using these tools the raw text is converted into several linguistic attributes each having appropriate value based on the content in the text, which in turn helps to predict personality. 
Social Network Features: As defined them above, these values are taken from the Facebook application are used directly. 

Multi-label classification
In this dataset Y-value is multi-label (big5 trait), which means a single X attribute contributes to one or more Y-values. 
To solve the Multi-Label classification problem, we first need to decompose it into multiple single label classification this step is called problem transformation. There are several problem transformation techniques such as Binary relevance (BR), Label Powerset (LP) & Classifier Chains (CC). Here I use Binary relevance.
Initially,
x1, x2, x3…Xn --> y1, y2, y3, y4, y5
Now, 
x1, x2, x3 --> y1
x1, x2, x3 --> y2
x1, x2, x3 --> y3
           …....
  
Example:

Step 1: X-variables are outcomes of the LIWC tools and network features values & its plotted against Y1 say (Extraversion), now we calculate the Pearson correlations between all the X-variables and Y1. 
Select the correlated attributes having r value higher than 0.05, rest of the x-variable are filtered out, then SMO classifier is applied over, hence we could predict which all the x-factors that contribute to predicting extraversion(y-value). 
Step 2: This is carried out with same X-variables and Y2(agreeableness), and we follow the same procedures as above.
 



Statistical Analysis:
Imported the ‘myPersonality.csv’ dataset, and have create another dataset which’s is a subset of it with only the multi-labels and social network features. 
 
Since this is a multi-label dataset, I’m decomposing it into multiple single dataset. 
Here I’m calculating the “Pearson correlation” between each of the X-variable and Y1, Y2, Y3 .. respectively.
Extraversion:
 
My assumption based on this correlation, 
a.	Network size is highly correlated with the extraversion with 0.37, which means if a student’s friend list is more it seems like he’s a social able person. 
b.	Even with betweenness shows up a significant correlation between extraversion with 0.27, as if the individual is critical flow for the information between two people his betweenness is high and its significantly correlated with the ‘extraversion’.
c.	 Similarly, with brokerage this even has the 0.28 of the correlation. 
d.	Its also to be noted that transitivity having negative correlation with ‘extraversion’. 
Neuroticism 
 
Couldn’t see any major relationships with ‘Neuroticism’ among any of the features, however ‘network size’ denotes individuals with less number friends are likely to be anxious. 
No significant relationship with other variables.


Agreeableness
 
Agreeableness defines friendly or cooperative type of individual, even here couldn’t witness any significant correlations, how transitivity shows up negative -0.21.  
Conscientiousness

 
High in conscientiousness denotes individuals are efficient, ordered. Unfortunately, none of the attributes are correlating.
Openess
 
High in Openness of an individual could be more imaginative, artistic and more, but here there’s no much correlation with any of the x-variables for the y.
 
Conclusion:
Based on analyzing the dataset found this information to be important
a.	This is a multi-label dataset, hence needs to be decomposed into multiple single label use it, this step is named problem transformation.
b.	Found significant correlation between network size attribute and extraversion.
c.	Couldn’t find any major relationships with the x variables other than the above. 
d.	The raw texts need to be transformed into several attributes using any of the natural language text processing tools, to obtain a better accuracy in predicting the individual’s personality.
e.	Social network feature alone doesn’t contribute much to the personality prediction with this dataset.
f.	Combination of both is required. 

Future:
I’d be using any of the NLP tools to break down the raw status texts to come up with better insights.