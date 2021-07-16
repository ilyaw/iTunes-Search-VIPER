//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 08.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    static let reuseId = "SongCell"
    
    private(set) lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "noImage")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        return label
    }()
    
    private(set) lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .grey
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()
    
    private(set) lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .grey
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    func configure(with model: SongCellModel) {
        titleLabel.text = model.songTitle
        artistLabel.text = model.authorTitle
        collectionNameLabel.text = model.albumTitle
        
        if let urlPhoto = model.coverPhoto {
            downloadImage(urlPhoto)
        }
    }
    
    private func downloadImage(_ url: String) {
        ImageDownloader.getImage(fromUrl: url) { [weak self] (image, _) in
            DispatchQueue.main.async {
                self?.coverImageView.image = image
            }
        }
    }
    
    private func setupCell() {
        self.contentView.addSubview(coverImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(artistLabel)
        self.contentView.addSubview(collectionNameLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.coverImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.coverImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.coverImageView.heightAnchor.constraint(equalToConstant: SongDetailConstants.smallArtworkSize.height),
            self.coverImageView.widthAnchor.constraint(equalToConstant: SongDetailConstants.smallArtworkSize.width),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.coverImageView.rightAnchor, constant: 8.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0),
            
            self.artistLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5.0),
            self.artistLabel.leftAnchor.constraint(equalTo: self.coverImageView.rightAnchor, constant: 8.0),
            self.artistLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0),

            self.collectionNameLabel.topAnchor.constraint(equalTo: self.artistLabel.bottomAnchor, constant: 5.0),
            self.collectionNameLabel.leftAnchor.constraint(equalTo: self.coverImageView.rightAnchor, constant: 8.0),
            self.collectionNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0),
        ])
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        artistLabel.text = nil
        collectionNameLabel.text = nil
        coverImageView.image = nil
    }
}
