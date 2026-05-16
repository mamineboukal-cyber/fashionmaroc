from app import db

class Categorie(db.Model):
    __tablename__ = 'categorie'
    id_categorie = db.Column(db.Integer, primary_key=True)
    libelle_categorie = db.Column(db.String(50), nullable=False)
    description = db.Column(db.String(200))
    produits = db.relationship('Produit', backref='categorie', lazy=True)

class Fournisseur(db.Model):
    __tablename__ = 'fournisseur'
    id_fournisseur = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(100), nullable=False)
    telephone = db.Column(db.String(20))
    email = db.Column(db.String(100))
    adresse = db.Column(db.String(200))

class Produit(db.Model):
    __tablename__ = 'produit'
    id_produit = db.Column(db.Integer, primary_key=True)
    reference = db.Column(db.String(20), nullable=False, unique=True)
    libelle = db.Column(db.String(100), nullable=False)
    prix_vente = db.Column(db.Numeric(10,2), nullable=False)
    taille = db.Column(db.String(10))
    couleur = db.Column(db.String(30))
    id_categorie = db.Column(db.Integer, db.ForeignKey('categorie.id_categorie'), nullable=False)
    stock = db.relationship('Stock', backref='produit', uselist=False)

class Stock(db.Model):
    __tablename__ = 'stock'
    id_stock = db.Column(db.Integer, primary_key=True)
    quantite_disponible = db.Column(db.Integer, nullable=False, default=0)
    seuil_minimum = db.Column(db.Integer, nullable=False, default=5)
    emplacement_rayon = db.Column(db.String(10))
    id_produit = db.Column(db.Integer, db.ForeignKey('produit.id_produit'), nullable=False, unique=True)

    @property
    def est_en_alerte(self):
        return self.quantite_disponible < self.seuil_minimum

class Commande_Fournisseur(db.Model):
    __tablename__ = 'commande_fournisseur'
    id_commande = db.Column(db.Integer, primary_key=True)
    date_commande = db.Column(db.Date, nullable=False)
    statut = db.Column(db.Enum('EN_ATTENTE','EN_COURS','LIVREE'), nullable=False)
    montant_total = db.Column(db.Numeric(10,2))
    date_livraison_prev = db.Column(db.Date)
    id_fournisseur = db.Column(db.Integer, db.ForeignKey('fournisseur.id_fournisseur'), nullable=False)
    fournisseur = db.relationship('Fournisseur', backref='commandes')
    lignes = db.relationship('Ligne_Commande', backref='commande', lazy=True)

class Ligne_Commande(db.Model):
    __tablename__ = 'ligne_commande'
    id_ligne = db.Column(db.Integer, primary_key=True)
    quantite_commandee = db.Column(db.Integer, nullable=False)
    prix_unitaire_achat = db.Column(db.Numeric(10,2), nullable=False)
    quantite_recue = db.Column(db.Integer, nullable=False, default=0)
    id_commande = db.Column(db.Integer, db.ForeignKey('commande_fournisseur.id_commande'), nullable=False)
    id_produit = db.Column(db.Integer, db.ForeignKey('produit.id_produit'), nullable=False)
    produit = db.relationship('Produit', backref='lignes')