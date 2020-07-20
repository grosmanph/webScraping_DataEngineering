def get_books(book_containers,html_soup):

    for j in range(0,len(book_containers)):
        list_prices.append(book_containers[j].find_all('div')[1].find_all('p')[0].text.split('£')[1])
                
        is_in_stock.append( 'Yes' if 'In stock' in book_containers[j].find_all('div')[1].find_all('p')[1].text else 'No')
                
        list_stars.append(book_containers[j].find_all('p')[0]['class'][1])
                
        list_titles.append(book_containers[j].find_all('div')[0].a.img['alt'])
                
        list_categories.append(html_soup.title.text.split('|')[0].strip())
      
    return