INSERT INTO manga (name)
VALUES ('My Hero Academia'), ('One Piece'), ('Attack on Titan');

INSERT INTO novel (name)
VALUES ('To Kill a Mockingbird'), ('1984'), ('The Great Gatsby');

INSERT INTO comment (text, belongs_to_id, type)
VALUES ('Great manga!', 1, 'manga'), 
        ('Intriguing plot.', 2, 'manga'), 
        ('Unexpected twists!', 3, 'manga'), 
        ('A timeless classic.', 1, 'novel'), 
        ('Scary but thought-provoking.', 2, 'novel'), 
        ('A masterful character study.', 3, 'novel'),
        ('The artwork is brilliant!', 1, 'manga'), 
        ('The story arc is well-developed.', 2, 'manga'), 
        ('So many memorable characters.', 3, 'manga'), 
        ('It gets better with every read.', 1, 'novel'), 
        ('A chilling dystopian vision.', 2, 'novel'), 
        ('An essential piece of American literature.', 3, 'novel'), 
        ('I love the humor in this manga.', 1, 'manga'), 
        ('A wonderful adventure story.', 2, 'manga'), 
        ('The ending was so emotional.', 3, 'manga'), 
        ('A story of morality and justice.', 1, 'novel'), 
        ('A frightening portrayal of totalitarianism.', 2, 'novel'), 
        ('The symbolism is stunning.', 3, 'novel'), 
        ('The characters are so relatable.', 1, 'manga'), 
        ('An epic tale of pirates and treasure.', 2, 'manga'), 
        ('The plot twists are amazing.', 3, 'manga');