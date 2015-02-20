//
//  MJSCConcurrenceViewController.m
//  Concurrencia
//
//  Created by María Jesús Senosiain Caamiña on 20/02/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCConcurrenceViewController.h"

@interface MJSCConcurrenceViewController ()

@end

@implementation MJSCConcurrenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self withImage:^(UIImage *image) {
        self.photoView.
    }]
}


// Descarga sincrona: bloquea
- (IBAction)syncDownload:(id)sender {
    
    
    NSURL *url = [NSURL URLWithString:@"http://gemelasdavalos.net/img/deluxe%20(3).jpg"];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imgData];
    
    self.protoView.image = img;
}

- (IBAction)asyncDownload:(id)sender {
    
    // Creamos una cola: los parametros no llevan @ ni leches porque es una función de C!
    dispatch_queue_t download = dispatch_queue_create("download", NULL);
    
    // Le enviamos un bloque
    dispatch_async(download, ^{
        
        NSURL *url = [NSURL URLWithString:@"http://cdn.brosome.com/wp-content/uploads/2011/10/Catalina-Otalvaro-Besame-lingerie-5.jpg"];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.protoView.image = img;

        });
        
    });
    
}

- (IBAction)asyncProDown:(id)sender {
    
    [self withImage:^(UIImage *image) {
        self.protoView.image = image;
        
        // Si eres muy desconfiado, se puede poner esto para forzar el hilo que queramos
        //dispatch_async(dispatch_get_main_queue(), ^{
        //    self.protoView.image = image;
        //});
        
    }];
    
}


-(void)withImage:(void (^)(UIImage *image)) completionBlock {
    
    // Envío un bloque en la cola del sistema
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0) , ^{
        
        NSURL *url = [NSURL URLWithString:@"http://cdn.brosome.com/wp-content/uploads/2011/10/Catalina-Otalvaro-Besame-lingerie-5.jpg"];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        
        // una vez que tengo la imagen, se la paso al bloque de finalización
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(img);
        });

    });
    
    
    // mandarle un bloque
}

@end
